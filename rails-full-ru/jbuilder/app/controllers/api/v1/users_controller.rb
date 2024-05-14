# frozen_string_literal: true

class Api::V1::UsersController < Api::ApplicationController
  def index
    @users = User.includes(:posts).all
    respond_to do |format|
      format.json { render :index }
    end
  end

  def show
    @user = User.includes(:posts).find(params[:id])
    respond_to do |format|
      format.json { render :show }
    end
  end
end
