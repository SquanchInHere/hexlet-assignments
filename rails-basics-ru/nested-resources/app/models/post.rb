# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :post_comments

  validates :title, presence: true
  validates :body, length: { maximum: 500 }
end
