class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @users = User.all
    @statuses = Status.all
  end

  def create
    @task = Task.new(task_params)
    @task.status = Status.find status_params[:id]
    @task.user = User.find user_params[:id]

    return redirect_to task_path(@task), notice: 'Task Created successfully' if @task.save

    render :new, notice: 'Task cannot created!'
  end

  def show
    @task = Task.find params[:id]
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    @task.status = Status.find status_params[:id]
    @task.user = User.find user_params[:id]

    return redirect_to task_path(@task), notice: "Task #{@task.id} updated!" if @task.update task_params

    render :new, notice: "Task #{@task.id} cannot be updated!"
  end

  def destroy
    @task = Task.find params[:id]
    message = "Task #{params[:id]} Deleted!"

    message = "Task #{params[:id]} cannot be Deleted!" unless @task.destroy

    redirect_to tasks_path, notice: message
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def user_params
    params.require(:task).require(:user).permit(:id)
  end

  def status_params
    params.require(:task).require(:status).permit(:id)
  end
end
