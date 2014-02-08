class LikesController < ApplicationController
  before_action :signed_in_user
  before_action :find_idea

  def create
    unless current_user.like?(@idea)
      like = current_user.likes.new idea: @idea
      like.save
    end
    redirect_to @idea
  end

  def destroy
    if current_user.like?(@idea)
      current_user.likes.where(idea_id: @idea.id).destroy_all
    end
    redirect_to @idea
  end

  private
  def find_idea
    @idea = Idea.where(id: params[:id]).first
  end
end
