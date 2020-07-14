require 'logger'

class SimpleLogger
  def initialize(app)
    @app = app
  end

  def call(env)

    File.open(File.expand_path('../log/app.log', __dir__), 'a') do |f|

      f.write "Request: #{env['REQUEST_METHOD']} #{request_path(env)}\n"

      status, headers, body = @app.call(env)

      f.write "Handler: #{env['simpler.controller'].class.name}##{env['simpler.action']}\n"
      f.write "Parameters: #{env['simpler.controller']&.params}\n"
      f.write "Response: #{status} OK [#{headers['Content-Type']}] #{env['simpler.template_name']}\n"

      [status, headers, body]
    end

  end

  private

  def request_path(env)
    result = env['PATH_INFO'].dup
    result << '?' unless env['QUERY_STRING'].empty?
    result << env['QUERY_STRING']
  end
end
