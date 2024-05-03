# frozen_string_literal: true

require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:two)

    @attrs = {
      title: Faker::Book.title,
      body: Faker::Books::Dune.quote
    }
  end

  test 'visiting the index' do
    visit posts_url

    assert_selector 'h1', text: 'Posts'
  end

  test 'create a post' do
    visit posts_url

    click_on 'New Post'

    fill_in 'Title', with: @attrs[:title]
    fill_in 'Body', with: @attrs[:body]

    click_on 'Create Post'

    assert_text 'Post was successfully created'
  end

  test 'show post' do
    visit posts_url

    click_on 'Show', match: :first

    assert_selector 'h1', text: @post.title
  end

  test 'add post comment' do
    visit posts_url

    within('table tbody tr:first-child') do
      click_on 'Show'
    end

    fill_in 'post_comment[body]', with: 'Test Comments'

    click_on 'Create Comment'

    assert_text 'Comment was successfully created.'
  end

  test 'update a post' do
    visit posts_url

    click_on 'Edit', match: :first

    fill_in 'Title', with: Faker::Book.title
    click_on 'Update Post'

    assert_text 'Post was successfully updated'
  end

  test 'destroy a post' do
    visit posts_url

    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Post was successfully destroyed.'
  end
end
