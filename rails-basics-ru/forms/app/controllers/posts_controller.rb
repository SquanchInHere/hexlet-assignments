# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.published_posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = 'Post was successfully created.'
      return redirect_to post_path(@post)
    end

    flash[:danger] = 'Failed to create post.'
    render :new, status: 422
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = 'Post was successfully Updated.'
      return redirect_to post_path(@post)
    end

    flash[:danger] = 'Failed to update post.'
    render :edit, status: 422
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:success] = 'Post was successfully deleted.'
      return redirect_to posts_path
    end

    flash[:danger] = 'Failed to delete post.'
    redirect_to post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :body, :published)
  end
end
