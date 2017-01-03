class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.includes(:routes).find_by(session_token: session[:session_token])
  end

  def login(user)
    user.reset_session_token!
    self.session[:session_token] = user.session_token
    current_user
  end

  def logout
    current_user.reset_session_token!
    self.session[:session_token] = nil
  end

  private

  def require_logged_in
    if current_user.nil?
      flash[:errors] = "You must be logged in!"
      redirect_to new_session_url
    end
  end


end
