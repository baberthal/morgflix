require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  it 'is invalid without an email' do
    user.email = nil
    expect(user).to_not be_valid
  end
end
