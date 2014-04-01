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
      column :organization
      default_actions
    end
    filter :email
    filter :username
    filter :current_sign_in_at
    filter :last_sign_in_at
    filter :sign_in_count
    filter :organization

    show do
      h3 user.username
 
      attributes_table do
        row :email
        row :username
        row :organization
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
        f.input :organization, :as => :select, :label_method => :organization_name
      end
      f.actions
    end

  end

  controller do
    def permitted_params
      params.permit(:utf8, :_method, :authenticity_token, :commit, :id, :user => [:email,:username, :password, :password_confirmation, :role_ids, :organization_id])
    end
    def update
      update! do |format|
        format.html { redirect_to '/admin/users' }
      end
    end
    def create
      create! do |format|
        format.html { redirect_to '/admin/users' }
      end
    end
    def destroy
      destroy! do |format|
        format.html { redirect_to '/admin/users' }
      end
    end
  end
  
end
