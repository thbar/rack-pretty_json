require './test/test_helper'

  
class RackPrettyJSONTest < Test::Unit::TestCase

  RAW_JSON = "{\"a\":4}"
  PRETTY_JSON = "{\n  \"a\": 4\n}"

  CURL_USER_AGENT = "libcurl-agent/1.0"
  BROWSER_USER_AGENT = "mozilla"

  def do_request(headers)
    app = lambda { |env| [200, headers, [RAW_JSON]] }
    request = Rack::MockRequest.env_for("/")
    
    Rack::PrettyJSON.new(app).call(request).last.last
  end
    
  context "with application/json content-type" do
    
    context "and a non-browser user agent" do
    
      should "not pretty print response body" do
        body = do_request({'Content-Type' => 'application/json', 'User-Agent' => CURL_USER_AGENT})
        assert_equal RAW_JSON, body
      end

    end
    
    context "and a browser user agent" do
      
      should "pretty print response body" do
        body = do_request({'Content-Type' => 'application/json', 'User-Agent' => BROWSER_USER_AGENT})
        assert_equal PRETTY_JSON, body
      end
      
    end
  end
  
  context "with another content-type" do

    context "with a non-browser user agent" do
      
      should "not pretty print response body" do
        body = do_request({'Content-Type' => 'text/html', 'User-Agent' => CURL_USER_AGENT})
        assert_equal RAW_JSON, body
      end

    end
    
    context "with a browser user agent" do

      should "not pretty print response body" do
        body = do_request({'Content-Type' => 'text/html', 'User-Agent' => BROWSER_USER_AGENT})
        assert_equal RAW_JSON, body
      end

    end
  end
  
end
