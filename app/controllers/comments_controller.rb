class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    find_idea

    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to @idea
    else
      redirect_to @idea
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :idea_id)
    end

    def find_idea
      @idea = Idea.find(@comment.idea_id)
    end
end
