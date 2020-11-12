class CommentsController < ApplicationController
  before_action :set_comment, only: [:like, :dislike]

  def create
    @comment = current_user.comments.build(comment_params)
  end

  def like
    toggle_like @comment, redirect_path: @comment.blog
  end

  def dislike
    toggle_dislike @comment, redirect_path: @comment.blog
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
