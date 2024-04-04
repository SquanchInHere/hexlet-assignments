require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @task = tasks(:one)
    @attrs = {
      name: Faker::Artist.name,
      description: Faker::Movies::HarryPotter.quote,
      status: Faker::Movies::HarryPotter.spell,
      creator: Faker::Movies::HarryPotter.character,
      performer: Faker::Movies::HarryPotter.character,
      completed: Faker::Boolean.boolean
    }
  end

  test 'tasks get index' do
    get tasks_url

    assert_response :success
    assert_select 'h1', 'Tasks'
  end

  test 'should get new' do
    get new_task_url
    assert_response :success
    assert_select 'h1', 'New Task'
  end

  test 'create task' do
    post tasks_url, params: { task: @attrs }

    task = Task.find_by! name: @attrs[:name]

    assert_redirected_to task_url(task)
  end

  test 'show task' do
    get task_url(@task)
    # debugger
    assert_response :success
    assert_select 'h1', 'Task details!'
    assert_select 'h4', 'Task 1'
    assert_select 'p', 'Task 1 Description'
  end

  test 'task get edit' do
    get edit_task_url(@task)
    assert_response :success
    assert_select "input[value='Task 1']"
  end

  test 'update task' do
    patch task_url(@task), params: { task: @attrs }
    assert_redirected_to task_url(@task)

    @task.reload

    assert { @task.name == @attrs[:name] }
  end

  test 'destroy task' do
    delete task_url(@task)

    assert_redirected_to tasks_url

    assert { !Task.exists? @task.id }
  end
end
