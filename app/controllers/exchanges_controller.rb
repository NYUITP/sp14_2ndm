class ExchangesController < InheritedResources::Base
  
   def create
     @exchange = Exchange.new(exchange_params)
     @exchange.save
     redirect_to_root_path
   end 
   
   def index
     @exchanges = Exchange.all
   end
   
   private
   def exchange_params
    params.require(:exchange).permit(exchange: [:name],exchange: [:nonce], exchange:[:signature],exchange: [:apikey])
   end
 
end
