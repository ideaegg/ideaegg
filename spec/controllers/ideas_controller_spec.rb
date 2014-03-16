require 'spec_helper'

describe IdeasController do
  let(:user) { Fabricate(:user) }

  describe 'GET index' do
    it "assigns all ideas as @ideas" do
      idea = Fabricate(:idea, user: user)
      get :index
      expect(assigns(:ideas)).to eq([idea])
    end
  end

  describe 'GET new' do
    it 'is redirected when not signed_in' do
      get :new
      response.should redirect_to(login_url)
    end
    it 'returns http success when signed_in' do
      sign_in user
      get :new
      response.should be_success
    end
  end

  describe 'POST create' do
    let(:idea_params) { Fabricate.attributes_for(:idea)}
    before(:each) do
      sign_in user
    end

    it 'render edit when fails' do
      idea_params.delete(:title)
      post :create, idea: idea_params
      expect(response).to render_template(:new)
    end

    it 'is redirected when not signed_in' do
      sign_out
      post :create, idea: idea_params
      response.should redirect_to(login_url)
    end

    it 'is redirected to idea page when signed_in' do
      post :create, idea: idea_params
      idea = user.ideas.first
      response.should redirect_to(idea_path(idea))
    end
    it 'creates a new idea' do
      expect {
        post :create, idea: idea_params
      }.to change{ user.ideas.count }.by(1)
    end
  end

  describe 'GET show' do
    let(:idea) { Fabricate(:idea, user: user) }

    it 'is redirected when not signed_in' do
      get :show, id: idea.id
      response.should redirect_to(login_path)
    end
    it 'assigns the idea' do
      get :show, id: idea.id
      assigns(:idea).should == idea
    end
    it 'incresaes the hits_count' do
      sign_in user
      expect {
        get :show, id: idea.id
        idea.reload
      }.to change { idea.hits_count }.by(1)
    end
  end

  describe 'GET edit' do
    let(:idea) { Fabricate(:idea, user: user) }

    it "returns http success when the idea belongs to current user" do
      sign_in user
      get :edit, id: idea.id
      response.should be_success
    end
    it "is redirected when the idea does not belong to current user" do
      another_user = Fabricate(:user)
      sign_in another_user
      get :edit, id: idea.id
      response.should redirect_to(root_url)
    end
  end

  describe 'PATCH update' do
    let(:idea) { Fabricate(:idea, user: user) }

    context 'signed_in' do
      before(:each) do
        sign_in user
      end

      it 'updates the idea' do
        new_title = 'new-title'
        idea_params = { title: new_title }
        patch :update, id: idea.id, idea: idea_params
        idea.reload.title.should == new_title
      end
      it 'render edit when fails' do
        idea_params = idea.attributes.merge!({ title: '' })
        patch :update, id: idea.id, idea: idea_params
        response.should render_template(:edit)
      end
    end

    context 'not signed_in' do
      it 'is redirected' do
        new_title = 'new-title'
        idea_params = { title: new_title }
        patch :update, id: idea.id, idea: idea_params
        response.should redirect_to(login_path)
      end
    end

    context 'not the owner' do
      it 'is redirected to root_path' do
        sign_in Fabricate(:user)
        idea_params = Fabricate.attributes_for(:idea)
        patch :update, id: idea.id, idea: idea_params
        response.should redirect_to(root_path)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:idea) { Fabricate(:idea, user: user) }
    let(:another_user) { Fabricate(:user) }

    it 'deletes the idea' do
      sign_in user

      expect {
        delete :destroy, id: idea.id
      }.to change{ user.reload.ideas.count }.by(-1)
    end
    it 'is redirected to root_path when not belongs to current user' do
      sign_in Fabricate(:user)

      delete :destroy, id: idea.id
      response.should redirect_to(root_path)
    end

    context "when user collected this idea"  do
      before do
        sign_in another_user
        another_user.likes.create idea: idea
        another_user.collections.create idea: idea
        another_user.reload
        sign_out
      end
      it "another_user's likes decrease" do
        sign_in user
        expect {
          delete :destroy, id: idea.id
          sign_out
          sign_in another_user
          another_user.reload
        }.to change { another_user.like_ideas.count }.by(-1)
      end
      it "another_user's collections not decrease" do
        sign_in user
        expect {
          delete :destroy, id: idea.id
          sign_out
          sign_in another_user
          another_user.reload
        }.to change { another_user.collect_ideas.with_deleted.count }.by(0)
      end
    end
    context "when user collected own idea"  do
      before do
        sign_in user 
        user.likes.create idea: idea
        user.collections.create idea: idea
        user.reload
      end
      it "another_user's likes decrease" do
        expect {
          delete :destroy, id: idea.id
          user.reload
        }.to change { user.like_ideas.count }.by(-1)
      end
      it "another_user's collections not decrease" do
        expect {
          delete :destroy, id: idea.id
          user.reload
        }.to change { user.collect_ideas.with_deleted.count }.by(-1)
      end
    end
  end
end
