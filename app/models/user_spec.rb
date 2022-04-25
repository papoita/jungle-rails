require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be created with firstname, lastname, email, password and password confirmation' do
      @user = User.new({
        first_name: "Papo",
        last_name: "Perez",
        email: "papo@hotmail.com",
        password: "abcdefg",
        password_confirmation: "abcdefg"
      })
      expect(@user).to be_valid
    end

    it 'not valid without first name' do
      @user = User.new({
        first_name: nil,
        last_name: "Perez",
        email: "papo@hotmail.com",
        password: "abcdefg",
        password_confirmation: "abcdefg"
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "Needs a firstname"
    end

    it 'not valid without lastname' do
      @user = User.new({
        first_name: "Papo",
        last_name: nil,
        email: "papo@hotmail.com",
        password: "abcdefg",
        password_confirmation: "abcdefg"
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "needs a lastname"
    end

    it 'not valid without email' do
      @user = User.new({
        first_name: "Papo",
        last_name: "Perez",
        email: nil,
        password: "abcdefg",
        password_confirmation: "abcdefg"
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "needs an email"
    end

    it 'not valid without password and password validation' do
      @user = User.new({
        first_name: "Papo",
        last_name: "Perez",
        email: "papo@hotmail.com",
        password: nil,
        password_confirmation: nil
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "needs password and password validation"
    end

    it 'Not valid if password and password confirmation are different' do
      @user = User.new({
        first_name: "papo",
        last_name: "perez",
        email: "papo@hotmail.com",
        password: "abcdefg",
        password_confirmation: "2"
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'Not valid if password is less than 6 characters' do
      @user = User.new({
        first_name: "papo",
        last_name: "perez",
        email: "papo@hotmail.com",
        password: "ab",
        password_confirmation: "ab"
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "Password must have more than 6 characters"
    end

    describe 'emails must be unique' do
      before(:all) do 
        @user = User.create({
          first_name: "Papo",
          last_name: "Perez",
          email: "papo@hotmail.com",
          password: "abcdefg",
          password_confirmation: "abcdefg"
        })
      end 

      it 'should not create with the same email' do
        @user2 = User.new({
          first_name: "Somebody",
          last_name: "Perez",
          email: "PAPO@HOTMAIL.COM",
          password: "2",
          password_confirmation: "2"
        })
        expect(@user2).to_not be_valid
        expect(@user2.errors.full_messages).to include "Email is already in use"
      end

      describe '.authenticate_with_credentials' do
        before(:all) do
          @user = User.create!({
            name: "Sebas",
            email: "sebas@hotmail.com",
            password: "sebastian",
            password_confirmation: "sebastian"
          })
        end

        it 'should authenticate with the right credentails' do
          email = "sebas@hotmail.com"
          password = "sebastian"
          @user2 = User.authenticate_with_credentials(email, password)
    
          expect(@user2).not_to be_nil
        end

        it 'valid login if spaces before and/or after their email' do
          email = " papo@hotmail.com    "
          password = abcdefg
          @user2 = User.authenticate_with_credentials(email, password)
    
          expect(@user2).not_to be_nil
        end

        it 'valid login if lower or uppercase email used' do
          email = "PApo@hotMAIL.com"
          password = abdcefg
          @user2 = User.authenticate_with_credentials(email, password)
    
          expect(@user2).not_to be_nil
        end

        end
    end
  end
end