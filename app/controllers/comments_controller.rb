class CommentsController < ApplicationController
before_action :find_post
before_action :find_comment

  def new
    @comment = Comment.new
  end

  def index
    @comments = @post.comments
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      @post.comments << @comment
      redirect_to post_comments_path(@post), flash: {succes: 'Comment created'}
    else
      render :new
    end
  end

  def destroy
    if current_user.comments.where(id: @comment.id)
      @comment.destroy
      redirect_to :back, flash: {succes: 'Comment deleted'}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find_by(id: params[:post_id])
  end

  def find_comment
    @comment = Comment.find_by(id: params[:id])
  end
end
