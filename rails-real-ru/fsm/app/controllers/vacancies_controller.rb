# frozen_string_literal: true

class VacanciesController < ApplicationController
  before_action :get_vacancy, only: %i[publish archive]

  def index
    @on_moderate = Vacancy.on_moderate
    @published = Vacancy.published
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)

    if @vacancy.save
      redirect_to vacancies_path, notice: 'Vacancy was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def publish
    if @vacancy.may_publish?
      @vacancy.publish
      @vacancy.save
    end

    redirect_to vacancies_path
  end

  def archive
    if @vacancy.may_archive?
      @vacancy.archive
      @vacancy.save
    end

    redirect_to vacancies_path
  end

  private

  def vacancy_params
    params.require(:vacancy).permit(:title, :description)
  end

  def get_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
end
