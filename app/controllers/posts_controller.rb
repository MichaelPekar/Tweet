class PostsController < ApplicationController
before_action :find_post

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, flash: {succes: 'Post created'}
    else
      render :new
    end
  end

  def destroy
    if current_user.posts.where(id: @post.id )
      @post.destroy
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
  end
end
