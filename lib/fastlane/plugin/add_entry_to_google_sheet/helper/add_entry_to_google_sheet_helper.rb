require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class AddEntryToGoogleSheetHelper
      # class methods that you define here become available in your action
      # as `Helper::AddEntryToGoogleSheetHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the add_entry_to_google_sheet plugin helper!")
      end
    end
  end
end
