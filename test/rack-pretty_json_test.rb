# encoding: UTF-8

require 'test_helper'
  
class RackPrettyJSONTest < Test::Unit::TestCase

  RAW_JSON = "{\"a\":4}"
  PRETTY_JSON = "{\n  \"a\": 4\n}"

  CURL_USER_AGENT = "libcurl-agent/1.0"
  BROWSER_USER_AGENT = "mozilla"

  def do_request(response_headers, request_headers, body = RAW_JSON)
    app = lambda { |env| [200, response_headers, [body]] }
    env = Rack::MockRequest.env_for("/", request_headers)
    
    response = Rack::PrettyJSON.new(app).call(env)
    response = Rack::MockResponse.new(*response) if response.is_a?(Array)
  end
    
  context "with application/json content-type" do
    
    context "and a non-browser user agent" do
    
      should "not pretty print response body" do
        response = do_request(
          { 'Content-Type' => 'application/json' },
          { 'HTTP_USER_AGENT' => CURL_USER_AGENT }
        )
        assert_equal RAW_JSON, response.body
      end

    end
    
    context "and a browser user agent" do
      
      should "pretty print response body" do
        response = do_request(
          { 'Content-Type' => 'application/json' },
          { 'HTTP_USER_AGENT' => BROWSER_USER_AGENT }
        )
        assert_equal PRETTY_JSON, response.body
      end
      
      should "pretty print response body even if a charset is provided" do
        response = do_request(
          { 'Content-Type' => 'application/json;charset=utf-8' },
          { 'HTTP_USER_AGENT' => BROWSER_USER_AGENT }
        )
        assert_equal PRETTY_JSON, response.body
      end
      
      should "modify the Content-Length based on modified content" do
       # Test not working - to be fixed
       response = do_request(
          { 'Content-Type' => 'application/json;charset=utf-8' }, 
          { 'HTTP_USER_AGENT' => BROWSER_USER_AGENT},
          "éphémère"
        )
       assert_equal (8 + 3).to_s, response.headers['Content-Length']
      end
      
    end
  end
  
  context "with another content-type" do

    context "with a non-browser user agent" do
      
      should "not pretty print response body" do
        response = do_request(
          { 'Content-Type' => 'text/html' },
          { 'HTTP_USER_AGENT' => CURL_USER_AGENT}
        )
        assert_equal RAW_JSON, response.body
      end

    end
    
    context "with a browser user agent" do

      should "not pretty print response body" do
        response = do_request(
          { 'Content-Type' => 'text/html' },
          { 'HTTP_USER_AGENT' => BROWSER_USER_AGENT }
        )
        assert_equal RAW_JSON, response.body
      end

    end
  end
  
end
