require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SecretHelper. For example:
#
# describe SecretHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SecretHelper, type: :helper do
  describe '#default_banner' do
    it 'returns a default banner' do
      expect(helper.default_banner)
        .to match(%r{/assets/images/default_banners/(.+).png})
    end
  end
end
