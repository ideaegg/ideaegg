require 'spec_helper'

describe SessionsController do
  before(:all) do
    @auth_provider = :development
    @auth = {
      uid: '123456',
      provider: @auth_provider,
      info: {
        email: 'development@example.com',
        name: 'username'
    }}

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:development] = OmniAuth::AuthHash.new(@auth)
  end

  describe 'GET create' do
    before(:each) do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:development]
    end

    it 'should create user if not exists' do
      expect {
        get :create, provider: :development
      }.to change { User.count }.by(1)
    end
    it 'should create authentication' do
      expect {
        get :create, provider: @auth_provider
      }.to change { Authentication.count }.by(1)
    end
    it 'should create user with auth info' do
      get :create, provider: @auth_provider
      assigns(:current_user)[:name].should == @auth[:info][:name]
    end
    it 'should create authentication with auth params' do
      get :create, provider: @auth_provider
      authentication = Authentication.first
      authentication.provider.should == @auth[:provider].to_s
      authentication.uid.should == @auth[:uid].to_s
    end
    it 'should sign in user if exists' do
      user = User.create_with_omniauth(@auth)
      get :create, provider: @auth_provider
      assigns(:current_user).should == user
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      @user = Fabricate(:user)
      sign_in(@user)
    end

    it 'should sign out the user' do
      delete :destroy
      assigns(:current_user).should be_nil
    end
  end

  describe 'GET failure' do
    before(:each) do
      OmniAuth.config.mock_auth[:failure] = :invalid_credentials
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:failure]
    end
    it 'should catch errors' do
      expect {
        get :failure
      }.not_to raise_error
    end
  end

end
