# frozen_string_literal: true

require 'faker'

20.times do
  Post.create(
    title: Faker::Books::Dune.title,
    body: Faker::Lorem.paragraph,
    summary: Faker::Lorem.paragraph(sentence_count: 3),
    published: [true, false].sample
  )
end
