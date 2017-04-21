module Fastlane
  module Actions
    class SupplyAptoideAction < Action
      def self.run(params)
        UI.message("The supply_aptoide plugin is working!")
      end

      def self.description
        "Upload metadata, screenshots and binaries to Aptoide."
      end

      def self.authors
        ["William Schurman"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Drop-in replacement for supply that uploads to Aptoide instead."
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "SUPPLY_APTOIDE_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
