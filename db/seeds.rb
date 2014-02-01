# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

table_names = %w(servers)

table_names.each do |table_name|
  path = "#{Rails.root}/db/seeds/#{Rails.env}/#{table_name}.rb"
  require(path) if File.exist?(path)
end