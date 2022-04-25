require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'Must have email and password' do
      @user = User.new({
        name: "Paola",
        email: "paola@mail.com",
        password: "abcdefg",
        password_confirmation: "abcdefg"
      })
      expect(@user).to be_valid
    end
    it 'invalid without password or password confirmation' do
      @user = User.new({
        name: "Paola",
        email: "paola@mail.com",
        password: nil,
        password_confirmation: nil
      })
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include("can't be blank")
    end
    it "must be invalid if password and password confirmation don't match" do
      @user = User.new({
        name: "Paola",
        email: "paola@mail.com",
        password: "abcdefg",
        password_confirmation: "123456"
      })
      expect(@user).to_not be_valid
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "Invalid if email already in use" do
      @user1 = User.new({
        name: "paola",
        email: "paola@mail.com",
        password: "abcdefg",
        password_confirmation: "abcdefg"
      })
      @user1.save!
      @user2 = User.new({
        name: "paola",
        email: "paola@mail.com",
        password: "abcdefg",
        password_confirmation: "abcdefg"
      })
      expect(@user2).to_not be_valid
      expect(@user2.errors[:email]).to include("has already been taken")
    end
    it "Invalid if password length is less than 5 characters" do
      @user = User.new({
        name: "paola",
        email: "paola@mail.com",
        password: "pass",
        password_confirmation: "pass"
      })
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include("is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "must successfully login with proper credentials" do
      @user = User.new({
        name: "paola",
        email: "paola@mail.com",
        password: "abcdefg",
        password_confirmation: "abcdefg"
      })
      @user.save!
      @user2 = User.authenticate_with_credentials("paola@mail.com", "abcdefg")
      expect(@user2).not_to be_nil
    end
  end
end