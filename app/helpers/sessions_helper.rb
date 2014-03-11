module SessionsHelper
  def sign_in(user)
    @current_user = user
    remember_me
    session[:current_user_id] = user.id
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= login_from_session || login_from_cookies
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
    forget_me
    session[:current_user_id] = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def remember_me
    current_user.remember_me
    cookies[:remember_token] = {
      value: current_user.remember_token,
      expires: 2.weeks.from_now,
      httponly: true
    }
  end
  def forget_me
    cookies.delete(:remember_token)
  end

  def login_from_session
    if session[:current_user_id].present?
      begin
        User.find session[:current_user_id]
      rescue
        session[:current_user_id] = nil
      end
    end
  end

  def login_from_cookies
    if cookies[:remember_token].present?
      if user = User.where(remember_token: cookies[:remember_token]).first
        session[:current_user_id] = user.id
        user
      else
        forget_me
        nil
      end
    end
  end
end
