class HomesController < ApplicationController
  before_action :requires_authentication, only: :index
  after_action :destroy_notification, only: :index

  def index
    @following = current_user.following
  end
end
