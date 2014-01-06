require 'spec_helper'

describe Idea do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @idea = user.ideas.build(title: "Hello", description: "Lorem ipsum")
  end

  subject { @idea }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  #its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @idea.user_id = nil }
    it { should_not be_valid }
  end
end
