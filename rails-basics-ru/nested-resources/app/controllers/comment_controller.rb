# frozen_string_literal: true

class CommentController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @comment = @post.post_comments.build
  end

  def create
    @comment = @post.post_comments.build(comment_params)
    return redirect_to @post, notice: 'Comment added successfully' if @comment.save

    render :new, notice: 'Something went wrong'
  end

  def edit; end

  def update
    return redirect_to @post, notice: 'Comment updated successfully' if @comment.update(comment_params)

    render :edit, notice: 'Something went wrong!'
  end

  def destroy
    redirect_to @post, notice: 'Comment successfully deleted' if @comment.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = PostComment.find(params[:id])
  end

  def comment_params
    params.require(:post_comment).permit(:comment, :post_id)
  end
end
