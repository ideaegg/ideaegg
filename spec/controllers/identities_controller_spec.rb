require 'spec_helper'

describe IdentitiesController do
  describe 'GET new' do
    it 'should catch errors' do
      expect {
        get :new
      }.not_to raise_error
    end
  end
end
