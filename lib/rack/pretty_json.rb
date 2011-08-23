require 'rack'
require 'json'

module Rack
  class PrettyJSON
    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      
      if should_pretty_print?(env, headers)
        content_length = 0
        pretty_body = body.map do |data|
          result = JSON.pretty_generate(JSON.parse(data))
          content_length += result.bytesize
          result
        end
        headers['Content-Length'] = content_length.to_s
        [status, headers, pretty_body]
      else
        [status, headers, body]
      end
    end

  private
    def should_pretty_print?(env, headers)
      return false unless headers['Content-Type'] =~ /^application\/json(;|$)/
      return false unless env['HTTP_USER_AGENT'] =~ /Mozilla/i
      true
    end
  end
end
