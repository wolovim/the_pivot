require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create(:user) }

  it 'is valid' do
    expect(user).to be_valid
  end

  it 'is invalid without a first name' do
    user.first_name = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without a last name' do
    user.last_name = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  # Not sure how to fix this one yet, DatabaseCleaner might help, or using
  # something other than let?
  xit 'is invalid without a unique email' do
    user2 = create(:user)
    expect(user2).not_to be_valid

    user3       = create(:user)
    user3.email = 'EMAiL@example.com'
    expect(user3).not_to be_valid
  end

  it "is invalid without a password" do
    user.password = nil
    expect(user).not_to be_valid
  end

  it "is invalid if it's optional username isn't betweeen 2 and 32 characters" do
    user.username = "a"
    expect(user).not_to be_valid

    user.username = "apasswordcantbelongerthan32characters"
    expect(user).not_to be_valid
  end

  it "is invalid with a password under 8 characters" do
    user.password = "1234"
    expect(user).to_not be_valid
  end
end
