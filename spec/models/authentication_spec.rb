require 'spec_helper'

describe Authentication do
  describe 'Association' do
    it { should belong_to(:user) }
  end

  describe 'Attributes' do
    before(:each) do
      @user = Fabricate(:user)
    end
    context '`provider' do
      before(:each) do
        @valid_attrs = Fabricate.attributes_for(:authentication)
      end
      it 'fails validation with duplicated provider of the user' do
        authentication = @user.authentications.create @valid_attrs
        attrs = Fabricate.attributes_for(:authentication,
                                         provider: authentication.provider)

        new_authentication = @user.authentications.new(attrs)
        new_authentication.should have(1).error_on(:provider)
      end
    end
    context 'uid' do
      before(:each) do
        @valid_attrs = Fabricate.attributes_for(:authentication)
      end
      it 'fails validation with duplicated uid of the provider' do
        authentication = @user.authentications.create @valid_attrs
        attrs = Fabricate.attributes_for(:authentication,
                                         provider: authentication.provider,
                                         uid: authentication.uid)

        new_authentication = @user.authentications.new(attrs)
        new_authentication.should have(1).error_on(:uid)
      end
      it 'fails validation with duplicated uid of the provider when diffrent user' do
        another_user = Fabricate(:user)
        authentication = @user.authentications.create @valid_attrs
        attrs = Fabricate.attributes_for(:authentication,
                                         provider: authentication.provider,
                                         uid: authentication.uid)

        new_authentication = another_user.authentications.new(attrs)
        new_authentication.should have(1).error_on(:uid)
      end
    end
  end
end
