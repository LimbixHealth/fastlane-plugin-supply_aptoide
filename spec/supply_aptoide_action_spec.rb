describe Fastlane::Actions::SupplyAptoideAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The supply_aptoide plugin is working!")

      Fastlane::Actions::SupplyAptoideAction.run(nil)
    end
  end
end
