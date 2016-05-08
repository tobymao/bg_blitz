dev = ENV['RACK_ENV'] == 'development'

if dev
  require 'logger'
  logger = Logger.new($stdout)
end

require 'roda'
require 'fortitude'
require 'shrine'
require 'rack/unreloader'

# better errors
if dev
  require 'better_errors'
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

# shrine
Shrine.plugin :sequel
Shrine.plugin :rack_file
Shrine.plugin :validation_helpers

if dev
  require "shrine/storage/file_system"
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store'),
  }
end

# reloader
def name_from_file(f)
  File.basename(f).sub(/\.rb\z/, '').capitalize
end

Unreloader = Rack::Unreloader.new(
  subclasses: %w[Roda],
  logger: logger,
  reload: dev
) { App }

Unreloader.require 'models.rb'
Unreloader.require('models') { |f| name_from_file(f) }
Unreloader.require('views') { |f| 'Views::' + name_from_file(f) }
Unreloader.record_dependency 'views/base.rb', 'views/page.rb'
Unreloader.record_dependency 'views/page.rb', 'views/home.rb'
Unreloader.require 'app.rb'

run(dev ? Unreloader : App.freeze.app)

