class CommentsController < ApplicationController
  def create
    find_idea
    @comment = current_user.comments.build(comment_params)
    @comment.idea_id = @idea.id

    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to @idea
    else
      redirect_to @idea
    end

  end

  private
    def comment_params
      entire_comment_params.permit(:content)
    end

    def entire_comment_params
      params.require(:comment)
    end

    def find_idea
      @idea = Idea.find(entire_comment_params[:idea_id])
    end
end
