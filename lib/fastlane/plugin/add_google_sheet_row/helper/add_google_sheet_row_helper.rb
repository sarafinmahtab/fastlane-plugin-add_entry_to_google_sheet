require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class AddGoogleSheetRowHelper
      # class methods that you define here become available in your action
      # as `Helper::AddGoogleSheetRowHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the add_google_sheet_row plugin helper!")
      end
    end
  end
end
