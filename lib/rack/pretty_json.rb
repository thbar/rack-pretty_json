require 'rack'
require 'json'

module Rack
  class PrettyJSON
    def initialize(app, options = {})
      @app = app
    end
    
    def call(env)
      status, headers, body = @app.call(env)
      if should_pretty_print?(headers)
        pretty_body = body.map do |data|
          JSON.pretty_generate(JSON.parse(data))
        end
        [status, headers, pretty_body]
      else
        [status, headers, body]
      end
    end
    
  private
    def should_pretty_print?(headers)
      return false unless headers['Content-Type'] == 'application/json'
      return false unless headers['User-Agent'] =~ /Mozilla/i
      true
    end
  end
end
