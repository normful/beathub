require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

# Rake::Task["db:create"].clear
# Rake::Task["db:drop"].clear
#
# desc "create the database"
# task "db:create" do
#   touch 'db/db.sqlite3'
# end
#
# desc "drop the database"
# task "db:drop" do
#   rm_f 'db/db.sqlite3'
# end

desc "db:drop and db:setup"
task "db:reset" do
  Rake::Task["db:drop"].invoke
  Rake::Task["db:setup"].invoke
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end
