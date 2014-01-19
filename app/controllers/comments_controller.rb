class CommentsController < ApplicationController
  before_action :find_idea

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.idea_id = @idea.id

    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to @idea
    else
      flash[:error] = @comment.errors.full_messages.join("<br />")
      redirect_to @idea
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_idea
    @idea = Idea.find(params[:idea_id])
  end
end
