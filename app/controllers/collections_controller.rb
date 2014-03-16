class CollectionsController < ApplicationController
  before_action :signed_in_user
  before_action :find_idea

  def create
    unless current_user.collected?(@idea)
      collection = current_user.collections.new idea: @idea 
      collection.save
    end
    redirect_to @idea
  end

  def destroy
    if current_user.collected?(@idea)
      current_user.collections.where(idea_id: @idea.id).destroy_all
    end
    redirect_to @idea
  end

  private
  def find_idea
    @idea = Idea.with_deleted.where(id: params[:id]).first
  end
end
