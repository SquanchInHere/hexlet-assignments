# frozen_string_literal: true

class Repository < ApplicationRecord
  include AASM

  validates :link, presence: true, uniqueness: true

  aasm do
    state :created, initial: true
    state :fetching
    state :fetched
    state :failed

    event :start_fetching do
      transitions from: %i[created failed fetched], to: :fetching, unless: :fetching?
    end

    event :fetch_success do
      transitions from: :fetching, to: :fetched
    end

    event :fetch_fail do
      transitions from: :fetching, to: :failed
    end
  end

  def fetch_data
    RepositoryLoaderJob.perform_now(id)
  end
end
