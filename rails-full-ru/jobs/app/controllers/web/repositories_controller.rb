# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def show
    @repository = Repository.find params[:id]
  end

  def create
    @repository = Repository.new(permitted_params)

    if @repository.save
      @repository.fetch_data
      redirect_to @repository, notice: 'Repository successfully created.'
    else
      render :new, alert: 'Failed to create repository.'
    end
  end

  def update
    @repository = Repository.find(params[:id])
    @repository.fetch_data

    redirect_to @repository, notice: 'Repository successfully updated.'
  end

  def update_repos
    Repository.order(:updated_at).each(&:fetch_data)

    redirect_to repositories_path, notice: 'All repositories are being updated.'
  end

  def destroy
    @repository = Repository.find params[:id]

    if @repository.destroy
      redirect_to repositories_path, notice: t('success')
    else
      redirect_to repositories_path, notice: t('fail')
    end
  end

  private

  def permitted_params
    params.require(:repository).permit(:link)
  end
end
