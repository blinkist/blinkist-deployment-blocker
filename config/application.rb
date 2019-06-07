require_relative 'boot'
require_relative 'config'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DeploymentBlocker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.middleware.use ::Rack::Deflater
    config.middleware.use ::Ping::Pong

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.active_job.queue_adapter = :async
    config.active_job.queue_adapter = ActiveJob::QueueAdapters::AsyncAdapter.new \
      min_threads: 1,
      max_threads: 2 * Concurrent.processor_count,
      idletime: 600.seconds
  end
end
