class StaticPagesController < ApplicationController
  def home
  	@ideas = Idea.order('likes_count DESC')
  end
end
