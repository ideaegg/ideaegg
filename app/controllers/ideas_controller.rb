class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @ideas = Idea.order('likes_count DESC')
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = current_user.ideas.build(idea_params)

    if @idea.save
      flash[:success] = "Idea created!"
      redirect_to @idea
    else
      render :new
    end
  end

  def show
    @idea.increment!(:hits_count)
    @new_comment = Comment.new
    @comments = @idea.comments.order("created_at asc")
  end

  def edit
  end

  def update
    if @idea.update(idea_params)
      flash[:success] = "Idea was successfully updated."
      redirect_to @idea
    else
      render 'edit'
    end
  end

  def destroy
    @idea.destroy
    redirect_to root_path
  end

  private

    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:title, :description)
    end

    def correct_user
      redirect_to root_url unless current_user.ideas.include?(@idea)
    end
end
