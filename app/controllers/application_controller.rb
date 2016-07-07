class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def create_notification(to, author, action, trackable)
    notification = to.notifications.build
    notification.author = author
    notification.action = action
    notification.trackable = trackable
    notification.save
  end

  def new_notification
    notificator = user.followers.pluck(:id)
    @notification = Notification.build(user_id: notificator, autor_id: current_user.id, )
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

