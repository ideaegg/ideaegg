class IdeasController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]

  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
  end
  
  def create
    @idea = Idea.new(idea_params)

    if @idea.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      redirect_to root_url
    end
  end

  private 
    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:title, :description)
    end
end
