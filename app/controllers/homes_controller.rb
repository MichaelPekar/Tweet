class HomesController < ApplicationController
  before_action :requires_authentication, only: :index
  def index
    @users = User.order(:name)
  end
end
