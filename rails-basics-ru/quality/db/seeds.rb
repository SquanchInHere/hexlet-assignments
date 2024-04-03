# frozen_string_literal: true

require 'faker'

10.times do
  Bulletin.create(
    title: Faker::Lorem.sentence(word_count: 3),
    body: Faker::Lorem.paragraph,
    published: [true, false].sample
  )
end
