# frozen_string_literal: true

class Bulletin < ApplicationRecord
  scope :published, -> { where(published: true) }
end
