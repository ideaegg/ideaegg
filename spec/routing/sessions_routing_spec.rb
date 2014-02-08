require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "to #create" do
      get('/auth/development/callback').should route_to('sessions#create', provider: 'development')
    end
    it "to #destroy" do
      delete('/log_out').should route_to('sessions#destroy')
    end
    it "to #destroy" do
      get('/auth/failure').should route_to('sessions#failure')
    end
  end
end
