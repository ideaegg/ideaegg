class IdeasController < ApplicationController
  before_action :set_idea, only: [:show]
  before_action :signed_in_user, only: [:new, :create, :destroy, :show]

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

  private

    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:title, :description)
    end
end
