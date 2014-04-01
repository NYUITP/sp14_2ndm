ActiveAdmin.register Exchange do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  ActiveAdmin.register Exchange do
    index do
      column :name
      column :nonce
      column :signature
      column :apikey
      default_actions
    end
    filter :name
    filter :nonce
    filter :signature
    filter :apikey

    show do
      h3 exchange.name
 
      attributes_table do
        row :name
        row :nonce
        row :signature
        row :apikey
       
      end
 
    end

    form do |f|
      f.inputs "Admin Details" do
        f.input :name
        f.input :nonce
        f.input :signature
        f.input :apikey
      end
      f.actions
    end

  end

  controller do
    def permitted_params
      #params.require(:exchange).permit(:name, :nonce, :signature, :apikey)
      params.permit(:utf8, :_method, :authenticity_token, :commit, :id, :exchange => [:name,:nonce, :signature, :apikey])
    end
    def update
      update! do |format|
        format.html { redirect_to '/admin/exchanges' }
      end
    end
    def create
      create! do |format|
        format.html { redirect_to '/admin/exchanges' }
      end
    end
    def destroy
      destroy! do |format|
        format.html { redirect_to '/admin/exchanges' }
      end
    end
  end
  
end
