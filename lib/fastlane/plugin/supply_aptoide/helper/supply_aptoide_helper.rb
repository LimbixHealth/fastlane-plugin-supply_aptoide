module Fastlane
  module Helper
    class SupplyAptoideHelper
      # class methods that you define here become available in your action
      # as `Helper::SupplyAptoideHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the supply_aptoide plugin helper!")
      end
    end
  end
end
