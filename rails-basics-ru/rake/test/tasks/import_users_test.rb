# frozen_string_literal: true

require 'test_helper'
require 'rake'

class ImportUsersTest < ActiveSupport::TestCase
  def setup
    App::Application.load_tasks if Rake::Task.tasks.empty?
  end

  test 'import users' do
    test_dir_path = File.dirname(__FILE__, 2)
    path = File.join test_dir_path, 'fixtures/files/users.csv'

    initial_user_count = User.count
    Rake::Task['hexlet:import_users'].invoke(path)
    new_user_count = User.count
    assert_equal initial_user_count + 100, new_user_count
  end
end
