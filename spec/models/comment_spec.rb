require 'spec_helper'

describe Comment do
  let(:user) { Fabricate(:user) }
  let(:idea) { Fabricate(:idea) }

  subject { Fabricate(:comment) }

  describe 'Respond to' do
    it { should respond_to(:content) }
    it { should respond_to(:user_id) }
    it { should respond_to(:idea_id) }
  end

  it { should be_valid }

  describe 'Attributes' do
    let(:comment) do
      idea.comments.build(content: "Test", user_id: user.id)
    end

    context '#content' do
      it 'is not valid with blank content' do
        comment.content = " "
        comment.should_not be_valid
      end
    end
  end
end
