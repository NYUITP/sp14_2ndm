require 'rest-client'
require 'json'
require 'httparty'
require 'multi_json'
require 'hashie'
require 'time'
require 'securerandom'
require 'coinbase'

class TransactionsController < InheritedResources::Base

    include HTTParty
    @types = {"Buy"=>"Buy","Sell"=>"Sell"}
    def initialize()
    	options={}
      @api_key = '9MB2hsDaSXvbevZ4'
      @api_secret = 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S'
      @coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
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
    def balance()
      @coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
      base_url = "http://localhost:4000/bitstamp_svcs/balance"
      print "i am here 1"
      #response = RestClient.get base_url
    
    #resource = RestClient::Resource.new 'http://localhost:4000/bitstamp_svcs/balance' 
    response = RestClient.get 'http://localhost:4000/bitstamp_svcs/balance?key=oo&signature=ooo&nonce=ijijiji'
    data = JSON.load response
    print data
    response2 = RestClient.get 'http://localhost:4000/coinbase_svcs/balance?key=oo&signature=ooo'
    data2 = JSON.load response2
    print data2
    reply = "{\"bitstamp\":\""+ data['btc_balance'] +"\",\"coinbase\":\""+ data2['amount']+"\"}"
    reply
  end
    def create

        @transaction = Transaction.new
        @coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
        amount = params[:transaction][:btc]
        price = params[:transaction][:usd]
        #print amount
        #options={}
        #options[:base_uri] ||= 'https://coinbase.com/api/v1'
      	#@base_uri = options[:base_uri]
      	#options[:format]   ||= :json
 		#options.each do |k,v|
        #	self.class.send k, v
      	#end
        params[:transaction][:exchange] = Exchange.where(:id => params[:transaction][:exchangeid].to_i).first
        #print params[:transaction][:exchange]
        type = params[:transaction][:order_type]
        if(params[:transaction][:exchangeid].to_i == 2)
          if(type == "Market Buy")
            #response = post('/buys', :qty => amount).to_hash
            response = RestClient.get 'http://localhost:4000/coinbase_svcs/buy?key=oo&signature=ooo&qty='+amount
            data = JSON.load response
          elsif(type == "Market Sell")
            #response = post('/sells', :qty => amount).to_hash
            response = RestClient.get 'http://localhost:4000/coinbase_svcs/sell?key=oo&signature=ooo&qty='+amount
            data = JSON.load response
          else
          end
        elsif(params[:transaction][:exchangeid].to_i == 1)
          if(type == "Limit Buy")
            response = RestClient.get 'http://localhost:4000/bitstamp_svcs/buy?key=oo&signature=ooo&nonce=ijijiji&amount='+amount+'&price='+price
            data = JSON.load response
            #print data
          elsif(type == "Limit Sell")
            response = RestClient.get 'http://localhost:4000/bitstamp_svcs/sell?key=oo&signature=ooo&nonce=ijijiji&amount='+amount+'&price='+price
            data = JSON.load response
          else
          end
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
        #print response
        if(params[:transaction][:exchangeid].to_i == 2)
            params[:transaction][:btc] = data["transfer"]["btc"]["amount"].to_f
            params[:transaction][:usd] = data["transfer"]["total"]["amount"].to_f

        elsif(params[:transaction][:exchangeid].to_i == 1)
            #params[:transaction][:btc] = response["amount"]
            params[:transaction][:usd] = data["price"].to_f
        else
        end

        response = balance()
        print "\n"
        print response
        data = JSON.load response
        if(params[:transaction][:exchangeid].to_i == 2)
            params[:transaction][:balance] = data["coinbase"].to_f

        elsif(params[:transaction][:exchangeid].to_i == 1)
            params[:transaction][:balance] = data["bitstamp"].to_f
        else
        end
        print 'BALANCE COLLECTED'
        @transaction.btc = params[:transaction][:btc]
        @transaction.usd  = params[:transaction][:usd]
        @transaction.exchange = params[:transaction][:exchange]
        @transaction.exchangeid = params[:transaction][:exchangeid].to_i
        @transaction.username = params[:transaction][:username]
        @transaction.order_type = params[:transaction][:order_type]
        @transaction.balance = params[:transaction][:balance]
        respond_to do |format|     
          if @transaction.save
          #redirect_to_root_path
          format.html { redirect_to(action:'index', notice: 'Transaction Successfull.') }
          format.json { render json: @transaction, status: :created, location: @transaction }
          else
            format.html { render action: 'new' }
            format.json { render json: @transaction.errors, status: :unprocessable_entity }
          end
        end
    end
end
