require 'spec_helper'

describe Idea do
  let(:user) { Fabricate(:user) }

  subject { Fabricate(:idea) }

  describe 'Respand to' do
    it { should respond_to(:title) }
    it { should respond_to(:description) }
    it { should respond_to(:user_id) }
  end

  it { should be_valid }

  describe 'Attributes' do
    let(:idea) do
      user.ideas.build(title: "Hello", description: "Lorem ipsum")
    end
    context '#title' do
      it "isnt valid with blank title" do
        idea.title = " "
        idea.should_not be_valid
      end
      it "isnt valid with title that is too long" do
        idea.title = "a" * 141
        idea.should_not be_valid
      end
    end
    context '#description' do
      it "isnt valid with blank description" do
        idea.description = " "
        idea.should_not be_valid
      end
    end
  end

end
