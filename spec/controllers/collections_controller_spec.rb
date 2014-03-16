require 'spec_helper'

describe CollectionsController do
  let(:user) { Fabricate(:user) }
  let(:idea) { Fabricate(:idea, user: user) }

  describe "POST 'create'" do
    before do
      sign_in user
    end
    it 'collect the idea' do
      expect {
        post :create, id: idea.id
        idea.reload
      }.to change { idea.collections_count }.by(1)
    end
    it 'is collected by user' do
      expect {
        post :create, id: idea.id
        user.reload
      }.to change { user.collect_ideas.count }.by(1)
    end

    context 'when collected' do
      before do
        user.collections.create idea: idea
      end

      it 'does nothing' do
        expect {
          post :create, id: idea.id
          user.reload
        }.to change { user.collect_ideas.count }.by(0)
      end
    end
  end

  describe "DELETE 'destroy'" do
    before do
      user.collections.create idea: idea
      sign_in user
      user.reload
      idea.reload
    end
    it 'not collect the idea' do
      expect {
        delete :destroy, id: idea.id
        idea.reload
      }.to change { idea.collections_count }.by(-1)
    end
    it 'is not collected by user' do
      expect {
        delete :destroy, id: idea.id
        user.reload
      }.to change { user.collect_ideas.count }.by(-1)
    end

    context 'when not collected' do
      before do
        user.collections.where(idea_id: idea.id).destroy_all
        user.reload
        idea.reload
      end

      it 'does nothing' do
        expect {
          delete :destroy, id: idea.id
          user.reload
        }.to change { user.collect_ideas.count }.by(0)
      end
    end
  end
end
