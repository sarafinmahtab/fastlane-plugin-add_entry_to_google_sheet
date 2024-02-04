describe Fastlane::Actions::AddEntryToGoogleSheetAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The add_entry_to_google_sheet plugin is working!")

      Fastlane::Actions::AddEntryToGoogleSheetAction.run(nil)
    end
  end
end
