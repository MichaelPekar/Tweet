class FollowersController < ApplicationController

  def index
    @followeds = current_user.followeds
    @followers = current_user.followers
  end

  def create
    followers = User.find_by(id: params[:id]).followers
    if followers.include?(current_user)
      redirect_to followers_path, flash: {errors: "Error"}
    else
      User.find_by(id: params[:id]).add_follower(current_user.id)
      redirect_to followers_path
    end
  end

  def destroy
    User.find_by(id: params[:id]).unfollow(current_user.id)
    redirect_to followers_path
  end
end