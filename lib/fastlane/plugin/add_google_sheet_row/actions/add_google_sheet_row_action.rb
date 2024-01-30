require 'fastlane/action'
require 'fastlane_core'
require 'google/apis/sheets_v4'
require_relative '../helper/add_google_sheet_row_helper'

module Fastlane
  module Actions
    class AddGoogleSheetRowAction < Action
#       OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
#       APPLICATION_NAME = 'Sheet'
#       CREDENTIALS_PATH = 'credentials.json'
#       TOKEN_PATH = 'token.yaml'

#       @@scope = Google::Apis::SheetsV4::AUTH_SPREADSHEETS

      def self.run(params)
        # Authenticate using the service account key
        @service = Google::Apis::SheetsV4::SheetsService.new
        @service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
            scope: 'https://www.googleapis.com/auth/spreadsheets',
            key_file: params[:service_account_path]
        )

        # Build the request body
        body = {
            values: [
              [values] # Replace with your row data in an array
            ]
        }

        # Append the row to the specified sheet and range
        @service.append_value_range(params[:sheet_id], params[:range], params[:body])

        FastlaneCore::UI.success("Row added successfully!")

#         @service = Google::Apis::SheetsV4::AUTH_SPREADSHEETS
#         @service.client_options.application_name = APPLICATION_NAME
#         @service.authorization = authorize
      end

#       def authorize
#         client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
#         token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
#         authorizer = Google::Auth::UserAuthorizer.new(client_id, @@scope, token_store)
#         user_id = 'default'
#
#         credentials = authorizer.get_credentials(user_id)
#         if credentials.nil?
#             url = authorizer.get_authorization_url(base_url: OOB_URI)
#             puts "Open the following URL in the browser and enter the " \
#                  "resulting code after authorization:\n" + url
#             code = gets
#             credentials = authorizer.get_and_store_credentials_from_code(
#                 user_id: user_id, code: code, base_url: base_url)
#         end
#         credentials
#       end
#
#       def add_row(sheet_id, range, values)
#         value_range = Google::Apis::SheetsV4::ValueRange.new(values: [values])
#         @service.append_spreadsheet_value(sheet_id, range, value_range, value_input_option: 'RAW')
#       end

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
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "ADD_GOOGLE_SHEET_ROW_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
