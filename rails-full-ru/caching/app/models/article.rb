# frozen_string_literal: true

class Article < ApplicationRecord
  def last_reading_date
    Rails.cache.fetch([self, "last_reading_date"], expires_in: 12.hours) do
      updated_at
    end
  end
end
