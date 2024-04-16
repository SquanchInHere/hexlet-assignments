require 'csv'
require 'active_support/core_ext'

namespace :hexlet do
  desc "TODO"
  task :import_users, [:dirname] => :environment do |task, args|
    CSV.foreach(args[:dirname], headers: true) do |row|
      row['birthday'] = Date.strptime(row['birthday'], "%m/%d/%Y")
      User.create!(row)
    end
  end

end
