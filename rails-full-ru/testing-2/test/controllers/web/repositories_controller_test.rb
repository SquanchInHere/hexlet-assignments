# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @repo = repositories :one

    @attrs = {
      link: 'https://github.com/octocat/Hello-World'
    }
  end

  test 'get index' do
    get repositories_url
    assert_response :success
  end

  test 'get new' do
    get new_repository_url
    assert_response :success
  end

  test 'should create' do
    response = load_fixture('files/response.json')

    stub_request(:get, 'https://api.github.com/repos/octocat/Hello-World')
      .to_return(
        status: 200,
        body: response,
        headers: { 'Content-Type' => 'application/json' }
      )

    post repositories_url, params: { repository: @attrs }

    repository = Repository.find_by @attrs

    assert { repository }
    assert { repository.description.present? }
    assert_redirected_to repository_url(repository)
  end

  test 'get edit' do
    get edit_repository_url(@repo)
    assert_response :success
  end

  test 'should update' do
    patch repository_url(@repo), params: { repository: @attrs }

    @repo.reload

    assert { @repo.link == @attrs[:link] }
    assert_redirected_to repositories_url
  end

  test 'destroy' do
    delete repository_url(@repo)

    assert { !Repository.exists? @repo.id }

    assert_redirected_to repositories_url
  end
end
