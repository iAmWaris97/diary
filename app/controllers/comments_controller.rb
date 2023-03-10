class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post, only: %i[new create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = @post

    if @comment.save
      redirect_to user_post_path(user_id: @post.author.id, id: @post.id)
    else
      flash.now[:alert] = @comment.errors.full_messages.first if @comment.errors.any?
      render :new, status: 400
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      redirect_to user_post_path(user_id: current_user.id, id: @comment.post_id), notice: 'Comment deleted successfully'
    else
      flash.new[:alert] = @comment.errors.full_messages.first if @comment.errors.any?
      render :show, status: 400
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
