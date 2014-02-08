require "spec_helper"

describe LikesController do
  describe 'routing' do
    it "routes to #create" do
      expect(post: '/ideas/1/like').to route_to('likes#create', id: '1')
    end
    it "routes to #destroy" do
      expect(delete: '/ideas/1/like').to route_to('likes#destroy', id: '1')
    end
  end
end
