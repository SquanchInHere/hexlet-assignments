# frozen_string_literal: true

class Api::UsersController < Api::ApplicationController
  before_action :set_user, only: %i[show]

  def index
    @user = User.all
    respond_with @user.as_json(except: %i[password_digest])
  end

  def show
    respond_with @user.as_json(except: %i[password_digest])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
