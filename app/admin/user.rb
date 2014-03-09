ActiveAdmin.register User do

  
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
  ActiveAdmin.register User do
    index do
      column :email
      column :username
      column :current_sign_in_at
      column :last_sign_in_at
      column :sign_in_count
      default_actions
    end
    filter :email
    filter :username
    filter :current_sign_in_at
    filter :last_sign_in_at
    filter :sign_in_count

    show do
      h3 user.username
 
      attributes_table do
        row :email
        row :username
      end
      table_for  user.roles do
        column "Role" do |role|
          role.name
        end
 
      end
 
    end

    form do |f|
      f.inputs "Admin Details" do
        f.input :email
        f.input :username
        f.input :roles, :as => :radio, :required => false
      end
      f.actions
    end

  end

  controller do
    def permitted_params
      params.permit(:utf8, :_method, :authenticity_token, :commit, :id, :user => [:email,:username, :password, :password_confirmation, :role_ids])
    end
  end
  
end
