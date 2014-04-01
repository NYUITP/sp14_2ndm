

  
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
  ActiveAdmin.register Organization do
    index do
      column :organization_name
      default_actions
    end
    filter :organization_name
    filter :exchanges, :as => :select, :multiple => :true
  
    show do
      h3 organization.organization_name
 
      attributes_table do
        row :organization_name
      end
      table_for  organization.exchanges do
        column "Exchanges" do |exch|
          exch.name
        end
      end
    end

    form do |f|
      f.inputs "Admin Details" do
        f.input :organization_name
        f.input :exchanges, :as => :select, :multiple => :true
      end
      f.actions
    end

  controller do
    def permitted_params
      params.permit(:utf8, :_method, :authenticity_token, :commit, :id, :organization => [:organization_name, :exchange_ids => []])
    end
    def update
      update! do |format|
        format.html { redirect_to '/admin/organizations' }
      end
    end
    def create
      create! do |format|
        format.html { redirect_to '/admin/organizations' }
      end
    end
    def destroy
      destroy! do |format|
        format.html { redirect_to '/admin/organizations' }
      end
    end
  end
  end

  
  
