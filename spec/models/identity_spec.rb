require 'spec_helper'

describe Identity do
  it "should create a new instance given a valid attributes" do
    expect(Fabricate.build :identity).to be_valid
  end
  describe 'Attributes' do
    let(:identity) { Fabricate(:identity) }
    context 'name' do
      it 'can not be blank' do
        expect(
          Fabricate.build(:identity, name: '')
        ).to have(2).error_on(:name)
      end
      it 'is unique' do
        expect(
          Fabricate.build(:identity, name: identity.name)
        ).to have(1).error_on(:name)
      end
      it 'is not case_sensitive' do
        expect(
          Fabricate.build(:identity, name: identity.name.upcase)
        ).to have(1).error_on(:name)
      end
      it 'passes when number, english character and under line' do
        expect(
          Fabricate.build(:identity, name: 'name_1')
        ).to be_valid
      end
      it 'fails when hyphen' do
        expect(
          Fabricate.build(:identity, name: 'name-1')
        ).to have(1).error_on(:name)
      end
      it 'fails when chinese character' do
        expect(
          Fabricate.build(:identity, name: '名字')
        ).to have(1).error_on(:name)
      end
    end

    context 'email' do
      it 'can not be blank' do
        expect(
          Fabricate.build(:identity, email: '')
        ).to have(2).error_on(:email)
      end
      it 'is unique' do
        expect(
          Fabricate.build(:identity, email: identity.email)
        ).to have(1).error_on(:email)
      end
      it 'is not case_sensitive' do
        expect(
          Fabricate.build(:identity, email: identity.email.upcase)
        ).to have(1).error_on(:email)
      end
    end

  end
end
