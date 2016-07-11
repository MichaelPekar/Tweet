class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def create_notification(to, author, trackable)
    notification = to.notifications.build(user_id: to.id, author_id: author.id, trackable_id: trackable.id, trackable_type: trackable.title)
    notification.save
  end

  def destroy_notification
    current_user.notifications.destroy_all
  end

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

