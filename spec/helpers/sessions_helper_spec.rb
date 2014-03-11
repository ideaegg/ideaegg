require 'spec_helper'

describe SessionsHelper do
  before(:each) do
    @user = Fabricate(:user)
  end

  describe 'sign_in' do
    it 'assigns the user as @current_user' do
      helper.sign_in(@user)
      helper.current_user.should == @user
    end
    it 'assigns session' do
      helper.sign_in(@user)
      session[:current_user_id].should == @user.id
    end
    it 'remembers the user' do
      helper.sign_in(@user)
      expect(cookies[:remember_token]).to eq @user.remember_token
    end
  end

  describe 'current_user' do
    it 'should return nil' do
      helper.current_user.should == nil
    end
    it 'should return the current_user' do
      helper.sign_in(@user)
      helper.current_user.should == @user
    end
    it 'should find user from db with session' do
      session[:current_user_id] = @user.id
      helper.current_user.should == @user
    end
  end

  describe 'current_user=' do
    it 'assigns the user' do
      helper.current_user = @user
      helper.current_user.should == @user
    end
  end

  describe 'sign_out' do
    before(:each) do
      helper.sign_in(@user)
    end
    it 'should sign out current_user' do
      helper.sign_out
      assigns(:current_user).should be_nil
    end
    it 'should destroy current_user session' do
      helper.sign_out
      session[:current_user].should be_nil
    end
    it 'deletes remember_token' do
      helper.sign_out
      expect(cookies[:remember_token]).to be_nil
    end
  end
end
