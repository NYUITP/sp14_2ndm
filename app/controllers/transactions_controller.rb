require 'rest-client'
require 'json'
require 'httparty'
require 'multi_json'
require 'hashie'
require 'time'
require 'securerandom'

class TransactionsController < InheritedResources::Base
    include HTTParty
    @types = {"Buy"=>"Buy","Sell"=>"Sell"}
    def initialize()
    	options={}
      @api_key = '9MB2hsDaSXvbevZ4'
      @api_secret = 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S'

      # defaults
      options[:base_uri] ||= 'https://coinbase.com/api/v1'
      @base_uri = options[:base_uri]
      options[:format]   ||= :json
      options.each do |k,v|
        self.class.send k, v
      end
      super
    end
    def get(path, options={})
      http_verb :get, path, options
    end

    def post(path, options={})
      http_verb :post, path, options
    end

    def put(path, options={})
      http_verb :put, path, options
    end

    def delete(path, options={})
      http_verb :delete, path, options
    end

    def self.whitelisted_cert_store
      return @cert_store if @cert_store
      path = File.expand_path(File.join(File.dirname(__FILE__), 'ca-coinbase.crt'))

      certs = [ [] ]
      File.readlines(path).each{|line|
        next if ["\n","#"].include?(line[0])
        certs.last << line
        certs << [] if line == "-----END CERTIFICATE-----\n"
      }

      @cert_store = OpenSSL::X509::Store.new

      certs.each{|lines|
        next if lines.empty?
        cert = OpenSSL::X509::Certificate.new(lines.join)
        @cert_store.add_cert(cert)
      }

      @cert_store
    end

    def ssl_options
      { verify: true, cert_store: self.class.whitelisted_cert_store }
    end

    def http_verb(verb, path, options={})
      nonce = options[:nonce] || (Time.now.to_f * 1e6).to_i
      message = nonce.to_s + @base_uri + path + options.to_json
      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @api_secret, message)

      headers = {
        'ACCESS_KEY' => @api_key,
        'ACCESS_SIGNATURE' => signature,
        'ACCESS_NONCE' => nonce.to_s,
        "Content-Type" => "application/json",
      }

      r = self.class.send(verb, path, {headers: headers, body: options.to_json}.merge(ssl_options))
      hash = Hashie::Mash.new(JSON.parse(r.body))
      #raise Error.new(hash.error) if hash.error
      #raise Error.new(hash.errors.join(", ")) if hash.errors
      hash
    end
    def create

        @coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
        amount = params[:transaction][:btc]
        print amount
        #options={}
        #options[:base_uri] ||= 'https://coinbase.com/api/v1'
      	#@base_uri = options[:base_uri]
      	#options[:format]   ||= :json
 		#options.each do |k,v|
        #	self.class.send k, v
      	#end
        type = params[:transaction][:order_type]
        if(type == "Buy")
          response = post('/buys', :qty => amount).to_hash
        elsif(type == "Sell")
          response = post('/sells', :qty => amount).to_hash
        else
        end
        
        #nonce = (Time.now.to_f * 1e6).to_i
        #base_url = "https://coinbase.com/api/v1/buys"
        #message = nonce.to_s + @base_uri + '/buys' + options.to_json
        #signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S', message)
        #headers = {
        #'ACCESS_KEY' => @api_key,
        #'ACCESS_SIGNATURE' => signature,
        #'ACCESS_NONCE' => nonce.to_s,
        #{}"Content-Type" => "application/json",
      #}
      #r = self.class.send(:post, base_url, {headers: headers, body: options.to_json})
      #hash = Hashie::Mash.new(JSON.parse(r.body))
		#response = RestClient.post base_url, { 'qty' => amount }.to_json, :content_type => :json, :accept => :json, 'ACCESS_KEY' => '9MB2hsDaSXvbevZ4','ACCESS_SIGNATURE' => signature,'ACCESS_NONCE' => nonce.to_s
		#data = response
		#@coinbase_his = data
		#@coinbase_response = Bitstamp.balance
        
        #r = @coinbase.buy!(amount)
        #puts r.error
        print response
        if(type == "Buy")
          params[:transaction][:btc] = response["transfer"]["btc"]["amount"]
          params[:transaction][:usd] = response["transfer"]["total"]["amount"]
        elsif(type == "Sell")
          params[:transaction][:btc] = response["transfer"]["btc"]["amount"].to_f*-1
          params[:transaction][:usd] = response["transfer"]["total"]["amount"].to_f*-1
        else
        end
        
        
        
        super
    end
end
