class IdentitiesController < ApplicationController
  before_action :require_no_logined

  def new
    @identity = request.env['omniauth.identity']
  end
end
