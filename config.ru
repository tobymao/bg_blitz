dev = ENV['RACK_ENV'] == 'development'

if dev
  require 'logger'
  logger = Logger.new($stdout)
end

require 'roda'
require 'fortitude'
require 'sanitize'
require 'rack/unreloader'

def name_from_file(f)
  File.basename(f).sub(/\.rb\z/, '').capitalize
end

Unreloader = Rack::Unreloader.new(
  subclasses: %w[Roda],
  logger: logger,
  reload: dev
) { App }

Unreloader.require('models.rb')
Unreloader.require('models') { |f| name_from_file(f) }
Unreloader.require('views') { |f| 'Views::' + name_from_file(f) }
Unreloader.record_dependency('views/base.rb', 'views/page.rb')
Unreloader.record_dependency('views/page.rb', 'views/home.rb')
Unreloader.require 'app.rb'

run(dev ? Unreloader : App.freeze.app)
