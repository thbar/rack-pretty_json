require 'test_helper'
  
class RackPrettyJSONTest < Test::Unit::TestCase

  RAW_JSON = "{\"a\":4}"
  PRETTY_JSON = "{\n  \"a\": 4\n}"

  context "Rack::PrettyJSON" do
    context "with content type equal to 'application/json'" do

      should "pretty print response body" do
        app = lambda { |env| [200, {'Content-Type' => 'application/json'}, [RAW_JSON]] }
        request = Rack::MockRequest.env_for("/")
        body = Rack::PrettyJSON.new(app).call(request).last
        assert_equal PRETTY_JSON, body.last
      end

    end
  end
  
end
