require 'spec_helper'

describe Idea do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @idea = Idea.new(title: "Hello", description: "Lorem ipsum", user_id: user.id)
  end

  subject { @idea }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
end
