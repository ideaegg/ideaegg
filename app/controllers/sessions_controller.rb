class SessionsController < ApplicationController
  def create
    user = User.from_auth(request.env['omniauth.auth'])
    sign_in user

    flash[:success] = "Welcome #{user.name}!"
    redirect_to root_path
  end

  def destroy
    sign_out

    flash[:success] = "Log out successfully!"
    redirect_to root_path
  end

  def failure
    flash[:error] = params[:message]
    redirect_to root_path
  end
end
