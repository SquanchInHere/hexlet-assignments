# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, :body, :summary, presence: true
  validates :published, inclusion: { in: [true, false] }

  scope :published_posts, -> { where(published: true).order(created_at: :desc) }
end
