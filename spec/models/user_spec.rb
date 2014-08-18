require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'is valid' do
    user = build_user(valid_params)
    expect(user).to be_valid
  end

  it 'is invalid without a first name' do
    user = build_user(last_name: "Doe", email: "john@example.com")
    expect(user).not_to be_valid
  end

  it 'is invalid without a last name' do
    user = build_user(first_name: "John", email: "john@example.com")
    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user = build_user(first_name: "John", last_name: "Doe")
    expect(user).not_to be_valid
  end

  it 'is invalid without a unique email' do
    user = User.create(first_name: 'Jane',
                       last_name: 'Doe',
                       email: 'email@example.com',
                       password: 'swordfish')
    expect(user).to be_valid

    user2 = User.create(first_name: 'Jane',
                        last_name: 'Doe',
                        email: 'email@example.com',
                        password: 'swordfish')
    expect(user2).not_to be_valid
  end

  it "is invalid if it's optional username betweeen 2 and 32 characters" do
    user = build_user(first_name: 'John',
                      last_name: 'Doe',
                      email: 'email@example.com',
                      username: 'goodusername',
                      password: 'swordfish')
    expect(user).to be_valid

    user = User.new(first_name: 'John',
                    last_name: 'Doe',
                    email: 'email@example.com',
                    username: 'a',
                    password: 'swordfish')
    expect(user).not_to be_valid

    user = User.new(first_name: 'John',
                    last_name: 'Doe',
                    email: 'email@example.com',
                    username: 'abcdefghijklmnopqrstuvwxyz1234568',
                    password: 'swordfish')
    expect(user).not_to be_valid
  end

  it "is invalid without a password" do
    user          = build_user(valid_params)
    user.password = nil
    expect(user).not_to be_valid
  end

  it "is valid with a password" do
    user = build_user(valid_params)
    expect(user).to be_valid
  end

  it "is invalid with a password under 8 characters" do
    user = build_user(valid_params)
    user.password = "1234"
    expect(user).to_not be_valid
  end

  # curious about the best way to organize this, not sure if I should stay away
  # from letting :user float around with the let block and just ignore it in
  # the uniqueness test
  def build_user(options)
    User.create(options)
  end

  def valid_params
    {
      first_name: 'John',
      last_name: 'Doe',
      email: 'email@example.com',
      username: 'goodusername',
      password: 'swordfish'
    }
  end
end
