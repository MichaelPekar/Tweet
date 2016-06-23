class FollowersController < ApplicationController

  def index
    @followeds = current_user.following
    @followers = current_user.followers
    # ids = Relationship.where(follower_id: self.id).pluck(:id)
    # @followeds =  User.where(id: ids)
    # @followeds =  User.find_by(id: params[:id]).followers


  end

  def create
    followers = current_user.following
    if followers.include?(User.find_by(id: params[:id]))
      redirect_to followers_path, flash: {errors: "Error"}
    else
      current_user.add_follower(User.find_by(id: params[:id]).id)
      redirect_to followers_path
    end
  end

  def destroy
    User.find_by(id: params[:id]).unfollow(current_user.id)
    redirect_to followers_path
  end
end
