class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def requires_authentication
    puts '+++++++++++++++++++++++'
    puts current_user
    puts '+++++++++++++++++++++++'
      redirect_to log_in_path if current_user == nil
  end
end


