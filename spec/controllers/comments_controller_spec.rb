require 'spec_helper'

describe CommentsController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      expect(response).to be_success
    end
  end

end
