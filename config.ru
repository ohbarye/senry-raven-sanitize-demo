require 'rack'
require 'sentry-raven'

Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.sanitize_fields = %w[name]
end

class SentryRavenSanitizeDemo
  def call(env)
    r = Rack::Request.new(env)

    puts "=========Before========="
    puts r.POST
    puts env[Rack::RACK_REQUEST_FORM_HASH]
    before = env[Rack::RACK_REQUEST_FORM_HASH].dup

    begin
      raise "foo"
    rescue => ex
      Raven.capture_exception(ex)
    end

    puts "=========After========="
    puts r.POST
    puts env[Rack::RACK_REQUEST_FORM_HASH]
    after = env[Rack::RACK_REQUEST_FORM_HASH].dup

    [200, {"Content-Type" => "text/plain"}, ["before: #{before}, after: #{after}"]]
  end
end

use Raven::Rack
run SentryRavenSanitizeDemo.new
