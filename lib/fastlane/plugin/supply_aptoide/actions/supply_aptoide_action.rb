require 'json'

module Fastlane
  module Actions
    class SupplyAptoideAction < Action
      def self.run(params)
        repo = params[:repo]
        only_user_repo = params[:only_user_repo]
        apk = params[:apk]

        username, password = self.parse_json_credentials(params[:json_credential_path])

        UI.message "Fetching access token..."

        access_token = self.fetch_aptoid_access_token(username, password)
        return unless access_token

        UI.message "Got access token: '#{access_token}', starting upload..."

        command = "curl -s -X POST \"https://webservices.aptoide.com/webservices/3/uploadAppToRepo\""
        command += " -F access_token=#{access_token}"
        command += " -F repo=#{repo}"
        command += " -F mode=json"
        command += " -F apk=@\"#{apk}\""

        if only_user_repo
          command += " -F only_user_repo=true"
        end

        response = Actions.sh(command)
        unless response
          UI.error "Could not contact Aptoide to upload apk"
          return
        end

        parsed_response = nil
        begin
          parsed_response = JSON.parse(response)
        rescue JSON::ParserError
          UI.error "Invalid JSON returned by Apotide apk upload"
          return
        end

        if parsed_response["status"] != "OK"
          UI.error "Aptoide apk upload errors: #{parsed_response['errors']}"
          return
        end

        UI.message "Successfully uploaded apk to Aptoide: #{parsed_response['url']}"
      end

      def self.parse_json_credentials(json_credential_path)
        parsed = JSON.parse(File.read(File.expand_path(json_credential_path)))
        return parsed["username"], parsed["password"]
      end

      def self.fetch_aptoid_access_token(username, password)
        command_dict = {
          grant_type: "password",
          client_id: "Aptoide",
          mode: "json",
          username: username,
          password: password
        }

        command = "curl -s -H \"Content-Type: application/json\""
        command += " -X POST \"http://webservices.aptoide.com/webservices/3/oauth2Authentication\""
        command += " -d '#{command_dict.to_json}'"

        response = Actions.sh(command)
        unless response
          UI.error "Could not contact Aptoide to fetch access token"
          return nil
        end

        parsed_response = nil
        begin
          parsed_response = JSON.parse(response)
        rescue JSON::ParserError
          UI.error "Invalid JSON returned by Apotide access token fetch: #{response}"
          return nil
        end

        if parsed_response["error"]
          UI.error "Aptoide access token fetch error: #{response.error_description}"
          return nil
        end

        return parsed_response["access_token"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :json_credential_path,
                                       env_name: "SUPPLY_APTOIDE_JSON_CREDENTIAL_PATH",
                                       short_option: "-c",
                                       description: "JSON file containing object with username and password for authentication",
                                       verify_block: proc do |value|
                                         UI.user_error! "'#{value}' doesn't seem to be a JSON file" unless FastlaneCore::Helper.json_file?(File.expand_path(value))
                                         begin
                                           parsed_value = JSON.parse(File.read(File.expand_path(value)))
                                           UI.user_error! "JSON must be an object with \"username\" and \"password\" keys" if parsed_value["username"].empty? || parsed_value["password"].empty?
                                         rescue JSON::ParserError
                                           UI.user_error! "Could not parse Aptoide account json -- JSON::ParseError"
                                         end
                                       end),
          FastlaneCore::ConfigItem.new(key: :repo,
                                       env_name: "SUPPLY_APTOIDE_REPO",
                                       short_option: "-r",
                                       description: "User repository name"),
          FastlaneCore::ConfigItem.new(key: :only_user_repo,
                                       env_name: "SUPPLY_APTOIDE_ONLY_USER_REPO",
                                       short_option: "-x",
                                       optional: true,
                                       is_string: false,
                                       description: "If true, the application gets uploaded only to the repository given in the repo argument. If false or ommited, the application gets uploaded to the official apps repository as well"),
          FastlaneCore::ConfigItem.new(key: :apk,
                                       env_name: "SUPPLY_APK",
                                       description: "Path to the APK file to upload",
                                       short_option: "-b",
                                       default_value: Dir["*.apk"].last || Dir[File.join("app", "build", "outputs", "apk", "app-Release.apk")].last,
                                       verify_block: proc do |value|
                                         UI.user_error! "Could not find apk file at path '#{value}'" unless File.exist?(value)
                                         UI.user_error! "apk file is not an apk" unless value.end_with?('.apk')
                                       end)
        ]
      end

      def self.is_supported?(platform)
        [:android].include?(platform)
      end

      def self.description
        "Upload metadata, screenshots and binaries to Aptoide."
      end

      def self.authors
        ["wschurman"]
      end

      def self.details
        "Drop-in replacement for supply that uploads to Aptoide instead."
      end
    end
  end
end
