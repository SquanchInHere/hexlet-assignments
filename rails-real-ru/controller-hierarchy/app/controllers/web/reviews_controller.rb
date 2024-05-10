# frozen_string_literal: true

class Web::ReviewsController < Web::ApplicationController
  before_action :set_movie, except: :index

  def index
    @reviews = Review.limit(40).order(id: :desc)
  end

  def show
    @review = Review.find params[:id]
  end

  def new
    @review = Review.new
  end

  def edit
    @review = Review.find params[:id]
  end

  def create
    @review = @movie.reviews.new(permitted_review_params)

    if @review.save
      redirect_to movie_reviews_path(@movie)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @review = Review.find params[:id]

    if @review.update(permitted_review_params)
      redirect_to movie_reviews_path(@movie)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find params[:id]

    @review&.destroy!

    redirect_to movie_reviews_path(@movie), notice: t('.success')
  end

  private

  def permitted_review_params
    params.require(:review).permit(:body)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
