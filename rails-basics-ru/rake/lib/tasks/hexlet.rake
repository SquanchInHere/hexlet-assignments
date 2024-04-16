# frozen_string_literal: true

require 'csv'

namespace :hexlet do
  desc "Import users"
  task :import_users, [:dirname] => :environment do |_, args|
    CSV.foreach(args[:dirname], headers: true) do |row|
      row['birthday'] = Date.strptime(row['birthday'], '%m/%d/%Y')
      User.create!(row)
    end
  end

end
