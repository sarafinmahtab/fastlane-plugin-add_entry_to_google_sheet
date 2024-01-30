describe Fastlane::Actions::AddGoogleSheetRowAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The add_google_sheet_row plugin is working!")

      Fastlane::Actions::AddGoogleSheetRowAction.run(nil)
    end
  end
end
