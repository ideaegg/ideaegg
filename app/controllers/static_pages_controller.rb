class StaticPagesController < ApplicationController
  def home
  	ids = [3,20,38] 
  	ideas = Idea.find_all_by_id(ids)
  	@ideas = ids.map {|id| ideas.detect{|x| x.id == id}}
  end
end
