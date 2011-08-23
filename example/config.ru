require 'rack'
require 'sinatra'

$: << File.dirname(__FILE__) + '/../lib'
$: << File.dirname(__FILE__)

require 'rack/pretty_json'
require 'app'

use Rack::PrettyJSON
run Sinatra::Application
