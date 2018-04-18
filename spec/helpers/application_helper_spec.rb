RSpec.describe ApplicationHelper, type: :helper do
  describe '.oauth_provider_name' do
    it "return 'google' for :google_oauth2" do
      expect(oauth_provider_name(:google_oauth2)).eql? 'Google'
    end

    it "return default name for not recognized provider" do
      expect(oauth_provider_name(:xyz)).eql? 'Xyz'
    end
  end
end
