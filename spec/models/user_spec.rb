require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create(:user) }

  it 'is valid' do
    expect(user).to be_valid
  end

  it 'is valid without a last name' do
    user.last_name = nil
    expect(user).to be_valid
  end

  it 'is invalid without a first name' do
    user.first_name = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without a unique email' do
    create(:user, email: "my_email@example.com")
    expect(build(:user, email: "my_email@example.com")).not_to be_valid
    expect(build(:user, email: "J@EXAMPle.com")).to be_valid
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
