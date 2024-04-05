# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, :status, :creator, presence: true, length: { minimum: 3 }
  validates :completed, inclusion: { in: [true, false] }
end
