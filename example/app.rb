# encoding: UTF-8

require 'rubygems'
require 'bundler'
require 'sinatra'
require 'json'

get '/json' do
  content_type 'application/json', :charset => 'utf-8'
  {'hello' => 'world', 'hello2' => 'éphémère', 'values' => [1, 2, 3]}.to_json
end

get '/html' do
  "<body><html><h2>This ain't json - no json pretty print will occur</h2</body>"
end