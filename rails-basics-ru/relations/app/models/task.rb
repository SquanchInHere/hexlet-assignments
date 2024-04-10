class Task < ApplicationRecord
  belongs_to :status
  belongs_to :user

  validates :name, presence: true
end
