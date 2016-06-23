class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, flash: {succes: 'Post created'}
    else
      render :new
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
