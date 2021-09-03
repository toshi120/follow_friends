require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー登録ができる場合' do
      it '全ての項目が入力されていれば登録できる' do
        expect(@user).to be_valid
      end

      it '名前が10文字以下なら登録できる' do
        @user.name = 'aaaaaaaaaa'
        expect(@user).to be_valid
      end

    end


    context 'ユーザー登録ができない場合' do
      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Name can't be blank"
      end

      it 'nameが11文字以上では登録できない' do
        @user.name = 'aaaaaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "Name is too long (maximum is 10 characters)"
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank", "Email is invalid"
      end

      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'aaa.aaa.com'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end

      it 'emailが他のユーザーと重複していると登録できない' do
        other_user = FactoryBot.build(:user)
        other_user.email = "aaa@aaa.com"
        other_user.save
        @user.email = "aaa@aaa.com"
        @user.valid?
        expect(@user.errors.full_messages).to include "Email has already been taken"
      end

      it 'emailに全角文字があると登録できない' do
        @user.email = 'aaa@aaa.comあ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'passwordとpassword_confirmationが5文字以下だと登録できない' do
        @user.password = 'aaaaa'
        @user.password_confirmation = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password ='aaaaaa'
        @user.password_confirmation = 'bbbbbb'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

    end
  end
end
