require 'fastlane/action'
require 'fastlane_core'
require 'googleauth'
require 'google/apis/sheets_v4'
require_relative '../helper/add_entry_to_google_sheet_helper'

module Fastlane
  module Actions
    class AddEntryToGoogleSheetAction < Action
      def self.run(params)
        UI.message("#{params.values}")

        # Authenticate using the service account key
        @service = Google::Apis::SheetsV4::SheetsService.new
        @service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
            json_key_io: File.open(params[:service_account_path]),
            scope: 'https://www.googleapis.com/auth/spreadsheets'
        )

        # Build the request body
        value_range_object = {
          major_dimension: "ROWS",
          values: params[:body]
        }

        # Append the row to the specified sheet and range
        request_for_append_value_to_sheet(
            params[:sheet_id],
            params[:range],
            value_range_object
        )
      end

      def self.request_for_append_value_to_sheet(sheet_id, range, body)
        response = @service.append_spreadsheet_value(
            sheet_id,
            range,
            body,
            value_input_option: 'RAW'
        )

        if response
          FastlaneCore::UI.success("#{response.spreadsheet_id}")
        else
          error_message = "Sheet request failed (status: #{response.status})"
          case response.status
          when 400, 401, 403
            error_message << ": #{response.body}"
          when 422
            error_message << ": Invalid request format"
          else
            error_message << ": Unknown error"
          end
          raise error_message
        end
      end

      def self.description
        "A lane created to add a row in Google sheet."
      end

      def self.authors
        ["Shamsul Arafin Mahtab"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Automating sheet document entry by creating a lane which will a row in Google Sheet while a new Android APK will be uploaded to Google drive."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :service_account_path,
                               description: "Service account path set to environment for service account credentials key file",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :sheet_id,
                               description: "Google sheet ID where the entries will be added",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :range,
                               description: "Sheet ranges where the values will be stored",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :body,
                               description: "Sheet data to be added",
                                  optional: false,
                                      type: Array),
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        [:ios, :android].include?(platform)
        true
      end
    end
  end
end
