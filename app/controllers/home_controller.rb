require 'rest-client'
require 'json'

class HomeController < ApplicationController
  def index
	base_url = "https://www.bitstamp.net/api/ticker/"
	response = RestClient.get base_url
	data = JSON.load response
	@bitstamp = data["last"]
	base_url = "http://data.mtgox.com/api/2/BTCUSD/money/ticker"
	response = RestClient.get base_url
	data = JSON.load response
	@mtgox = data["data"]["last_local"]["display"]
	base_url = "https://coinbase.com/api/v1/prices/buy"
	response = RestClient.get base_url
	data = JSON.load response
	@coinbase = data["amount"]
  end
end
