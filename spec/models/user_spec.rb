require 'spec_helper'

describe User do
  before(:all) do
    @auth = {
      uid: '123456',
      provider: 'development',
      info: {
        email: 'development@example.com',
        name: 'username'
    }}
  end

  describe 'Assoications' do
    it { should have_many(:authentications) }
    it { should have_many(:likes) }
  end

  describe '#create_with_omniauth' do
    it 'should create new user' do
      expect {
        User.create_with_omniauth(@auth)
      }.to change { User.count }.by(1)
    end
    it 'should create new authentication' do
      expect {
        User.create_with_omniauth(@auth)
      }.to change { Authentication.count }.by(1)
    end
    it 'should create new authentication of the user' do
      user = User.create_with_omniauth(@auth)
      user.authentications.count.should == 1
    end
  end
end
