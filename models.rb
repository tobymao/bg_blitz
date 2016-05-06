require_relative 'db'

Sequel::Model.plugin :auto_validations
Sequel::Model.plugin :prepared_statements
Sequel::Model.plugin :prepared_statements_associations
Sequel::Model.plugin :timestamps, update_on_create: true
Sequel.default_timezone = :utc
DB.extension :pagination

if ENV['RACK_ENV'] == 'development'
  require 'logger'
  DB.loggers << Logger.new($stdout)
end
