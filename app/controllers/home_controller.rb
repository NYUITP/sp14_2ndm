require 'rest-client'
require 'json'

class HomeController < ApplicationController
  def index
  	if user_signed_in?
		base_url = "https://www.bitstamp.net/api/ticker/"
		response = RestClient.get base_url
		data = JSON.load response
		@bitstamp = data["last"]
		base_url = "https://coinbase.com/api/v1/prices/buy"
		response = RestClient.get base_url
		data = JSON.load response
		@coinbase = data["amount"]
		@holdings = Holding.all
		base_url = "https://www.bitstamp.net/api/transactions/"
		response = RestClient.get base_url
		data = JSON.load response
		@bitstamp_his = data
		@total = 0
		Holding.all.where(:user_id => current_user.id).each do |holding|
			@total = @total + holding.balance
		end
	end
  end
end
