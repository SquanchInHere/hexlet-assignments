# frozen_string_literal: true

class BulletinsController < ApplicationController
  def index
    @bulletins = Bulletin.published
  end

  def show
    @bulletin = Bulletin.published.find(params[:id])
  end
end
