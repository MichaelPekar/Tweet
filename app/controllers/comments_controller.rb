class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.all
  end

  def create
    @comment = current_user.comments.build(commentt_params)
    if @comment.save
      redirect_to user_path, flash: {succes: 'Commment created'}
    else
      render :new
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
