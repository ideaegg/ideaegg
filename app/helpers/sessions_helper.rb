module SessionsHelper
  def sign_in(user)
    @current_user = user
    session[:current_user_id] = user.id
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to login_url, notice: "Please sign in."
    end
  end

  def sign_out
    @current_user = nil
    session[:current_user_id] = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
