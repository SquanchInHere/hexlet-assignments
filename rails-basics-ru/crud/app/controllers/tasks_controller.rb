# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.limit(10).offset(4)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'Task was successfully created.'
      redirect_to task_path(@task)
    else
      flash[:danger] = 'Failed to create task.'
      render :new, status: 422
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task was successfully Updated.'
      redirect_to task_path(@task)
    else
      flash[:danger] = 'Failed to update task.'
      render :edit, status: 422
    end
  end

  def destroy
    @task = Task.find(params[:id])

    if @task.destroy
      flash[:success] = 'Task was successfully deleted.'
      redirect_to tasks_path
    else
      flash[:danger] = 'Failed to delete task.'
      redirect_to task_path(@task)
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :status, :creator, :performer, :completed)
  end
end
