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

  describe 'Respond to' do
    it { should respond_to(:like?) }
    it { should respond_to(:generate_remember_token) }
    it { should respond_to(:remember_me) }
    it { should respond_to(:remember_me!) }
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

  describe '#like_ideas' do
    let(:user) { Fabricate(:user) }
    let(:idea) { Fabricate(:idea) }

    it 'returns the like_ideas' do
      user.likes.create idea: idea
      user.like_ideas.should == [idea]
    end
  end

  describe '#like?' do
    let(:user) { Fabricate(:user) }
    let(:idea) { Fabricate(:idea) }

    before(:each) do
      user.likes.create idea: idea
    end

    it 'likes the idea' do
      user.like?(idea).should == true
    end
    it 'does not like the idea' do
      user.likes.destroy_all
      user.like?(idea).should == false
    end
  end

  describe '#remember_me' do
    let(:user) { Fabricate(:user) }

    it 'adds remember_token if remember_token doesnt exist' do
      user.remember_me
      expect(user.remember_token).to_not be_nil
    end
    it 'doesnt change remember_token if remember_token exists' do
      user.remember_me
      expect {
        user.remember_me
      }.to_not change(user, :remember_token)
    end
  end

  describe '#remember_me!' do
    let(:user) { Fabricate(:user) }

    it 'adds remember_token to user' do
      user.remember_me!
      expect(user.remember_token).to_not be_nil
    end
    it 'changes remember_token even if remember_token exists' do
      user.remember_me!
      expect {
        user.remember_me!
      }.to change(user, :remember_token)
    end
  end
end
