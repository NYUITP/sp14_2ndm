#require './util'
require 'rubygems'
require 'json'
require 'uri'
require 'net/https'

# Set the request URL
uri = URI.parse('https://www.bitstamp.net/api/ticker/');          
http = Net::HTTP.new(uri.host, uri.port)
# Send the GET request
resp = http.request(uri)

# Interpret the JSON response 
data = JSON.parse(resp.body)

puts data