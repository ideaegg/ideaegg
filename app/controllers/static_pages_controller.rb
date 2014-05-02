class StaticPagesController < ApplicationController
  def home
  	ids = [42,59,64] 
  	ideas = Idea.find_all_by_id(ids)
  	@ideas = ids.map {|id| ideas.detect{|x| x.id == id}}
  end
end
