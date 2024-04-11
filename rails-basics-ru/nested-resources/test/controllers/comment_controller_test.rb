# frozen_string_literal: true

require 'test_helper'

class CommentControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:two)
    @comment = post_comments(:two)
    @attrs = {
      comment: Faker::Fantasy::Tolkien.poem,
      post_id: @post.id
    }
  end

  test 'should create comment' do
    post post_comment_index_url(@post), params: { post_comment: @attrs }

    comment = PostComment.find_by @attrs

    assert { comment }
    assert_redirected_to post_url(@post)
  end

  test 'should get edit comment' do
    get edit_post_comment_url(@post, @comment)
    assert_response :success
  end

  test 'should update comment' do
    patch post_comment_url(@post, @comment), params: { post_comment: @attrs }

    @post.reload

    assert { @post.post_comments.find(@comment.id).comment == @attrs[:comment] }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy comment' do
    delete post_comment_url(@post, @comment)

    assert { !PostComment.exists?(@comment.id) }

    assert_redirected_to post_url(@post)
  end
end
