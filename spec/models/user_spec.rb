require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'is valid' do
    user = build_user
    expect(user).to be_valid
  end

  it 'is invalid without a first name' do
    user = build_user
    user.first_name = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without a last name' do
    user = build_user
    user.last_name = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user = build_user
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'is invalid without a unique email' do
    user = User.create(first_name: 'Jane', 
                       last_name: 'Doe', 
                       email: 'email@example.com')
    expect(user).to be_valid

    user2 = User.create(first_name: 'Jane', 
                        last_name: 'Doe', 
                        email: 'email@example.com')
    expect(user2).not_to be_valid
  end

  it "is invalid if it's optional username betweeen 2 and 32 characters" do
    user = User.new(first_name: 'John', 
                    last_name: 'Doe', 
                    email: 'email@example.com',
                    username: 'goodusername')
    expect(user).to be_valid

    user = User.new(first_name: 'John', 
                    last_name: 'Doe', 
                    email: 'email@example.com',
                    username: 'a')
    expect(user).not_to be_valid

    user = User.new(first_name: 'John', 
                    last_name: 'Doe', 
                    email: 'email@example.com',
                    username: 'abcdefghijklmnopqrstuvwxyz1234568')
    expect(user).not_to be_valid
  end

  # curious about the best way to organize this, not sure if I should stay away
  # from letting :user float around with the let block and just ignore it in 
  # the uniqueness test
  def build_user
    User.new(first_name: 'John', 
             last_name: 'Doe', 
             email: 'email@example.com') 
  end
end

