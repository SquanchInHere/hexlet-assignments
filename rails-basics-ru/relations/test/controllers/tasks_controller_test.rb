require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @john = users(:john)
    @task_one = tasks(:one)
  end

  test 'should get index' do
    get tasks_url
    assert_response :success
  end

  test 'should create task' do
    assert_difference('Task.count') do
      post tasks_url, params: {
        task: {
          name: 'New Task',
          description: 'New Task Descriptions',
          user: { id: @john.id },
          status: { id: statuses(:new).id }
        }
      }
    end

    assert_redirected_to task_url(Task.last)
  end

  test 'should show task' do
    get task_url(@task_one)
    assert_response :success
  end

  test 'should get edit' do
    get edit_task_url(@task_one)
    assert_response :success
  end

  test 'should update task' do
    patch task_url(@task_one), params: {
      task: {
        name: 'Updated Task',
        description: 'Update Task Descriptions',
        user: { id: @john.id },
        status: { id: statuses(:done).id }
      }
    }

    assert_redirected_to task_url(@task_one)
    @task_one.reload
    assert_equal 'Updated Task', @task_one.name
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete task_url(@task_one)
    end

    assert_redirected_to tasks_url
  end
end
