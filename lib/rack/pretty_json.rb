require 'rack'
require 'json'

module Rack
  class PrettyJSON
    def initialize(app, options = {})
      @app = app
    end
    
    def call(env)
      status, headers, body = @app.call(env)
      if false
        response
      else
        pretty_body = body.map do |data|
          JSON.pretty_generate(JSON.parse(data))
        end
        [status, headers, pretty_body]
      end
    end
  end
end
