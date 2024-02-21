# frozen_string_literal: true

require_relative 'model'
require 'date'

class Post
  include Model

  attribute :id, type: :integer
  attribute :title, type: :string
  attribute :body, type: :string
  attribute :created_at, type: :datetime
  attribute :published, type: :boolean
end

post = Post.new({
                  id: "1",
                  title: 'Hello World',
                  body: 'First post!',
                  created_at: '01/03/2021',
                  published: true
                })
# print post.attributes
# # puts post.id
# # print post.created_at
