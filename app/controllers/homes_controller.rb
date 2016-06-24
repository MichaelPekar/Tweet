class HomesController < ApplicationController
  before_action :requires_authentication, only: :index
  def index
    @following = current_user.following
  end
end
