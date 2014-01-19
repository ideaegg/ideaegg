require 'spec_helper'

describe CommentsController do

  let(:user) { Fabricate(:user) }
  let(:idea) { Fabricate(:idea, user: user) }


  describe "POST 'create'" do
    let(:comment_params) { Fabricate.attributes_for(:comment) }
    before(:each) do
      sign_in user
    end

    it "is redirected to idea page" do
      post :create, idea_id: idea.id, comment: comment_params
      response.should redirect_to(idea_path(idea))
    end
    it 'creates a new comment to the idea' do
      expect {
        post :create, idea_id: idea.id, comment: comment_params
      }.to change { idea.comments.count }.by(1)
    end
  end

end
