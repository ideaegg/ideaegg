module SessionsHelper
  def sign_in(user)
    @current_user = user
    session[:current_user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_out
    @current_user = nil
    session[:current_user_id] = nil
  end
end
