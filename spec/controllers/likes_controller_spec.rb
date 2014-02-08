require 'spec_helper'

describe LikesController do

  let(:user) { Fabricate(:user) }
  let(:idea) { Fabricate(:idea, user: user) }

  describe "POST 'create'" do
    before do
      sign_in user
    end
    it 'likes the idea' do
      expect {
        post :create, id: idea.id
        idea.reload
      }.to change { idea.likes_count }.by(1)
    end
    it 'is liked by user' do
      expect {
        post :create, id: idea.id
        user.reload
      }.to change { user.like_ideas.count }.by(1)
    end

    context 'when liked' do
      before do
        user.likes.create idea: idea
      end

      it 'does nothing' do
        expect {
          post :create, id: idea.id
          user.reload
        }.to change { user.like_ideas.count }.by(0)
      end
    end
  end

  describe "DELETE 'destroy'" do
    before do
      user.likes.create idea: idea
      sign_in user
      user.reload
      idea.reload
    end
    it 'unlikes the idea' do
      expect {
        delete :destroy, id: idea.id
        idea.reload
      }.to change { idea.likes_count }.by(-1)
    end
    it 'is unliked by user' do
      expect {
        delete :destroy, id: idea.id
        user.reload
      }.to change { user.like_ideas.count }.by(-1)
    end

    context 'when unliked' do
      before do
        user.likes.where(idea_id: idea.id).destroy_all
        user.reload
        idea.reload
      end

      it 'does nothing' do
        expect {
          delete :destroy, id: idea.id
          user.reload
        }.to change { user.like_ideas.count }.by(0)
      end
    end
  end

end
