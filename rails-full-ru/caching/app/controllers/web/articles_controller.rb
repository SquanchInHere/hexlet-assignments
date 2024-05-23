# frozen_string_literal: true

class Web::ArticlesController < Web::ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article =  Article.find(params[:id])
    fresh_when(@article)
  end
end
