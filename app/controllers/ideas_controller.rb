class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
  end
  
  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id

    if @idea.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      redirect_to new_idea_path
    end
  end

  def show
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
      @idea = current_user.ideas.find_by(id: params[:id])
      redirect_to root_url if @idea.nil?
    end
end
