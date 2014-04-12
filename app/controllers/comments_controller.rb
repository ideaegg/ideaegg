class CommentsController < ApplicationController
  #before_action :find_idea

  def create
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
    @comment = @commentable.comments.build(comment_params.merge(user: current_user))
    #@comment = current_user.comments.build(comment_params)

    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to @commentable
    else
      flash[:error] = @comment.errors.full_messages.join("<br />")
      redirect_to @commentable
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
