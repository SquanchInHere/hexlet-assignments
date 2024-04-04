# frozen_string_literal: true

require 'faker'

10.times do
  Task.create(
    name: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph,
    status: %i[in_progress failed].sample,
    creator: Faker::ProgrammingLanguage.creator,
    performer: %i[Jhon Tony ''].sample,
    completed: %i[true false].sample
  )
end
