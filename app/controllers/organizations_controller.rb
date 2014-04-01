class OrganizationsController < InheritedResources::Base
  before_filter :configure_permitted_parameters, if: :organizatios_controller?
  def new
     @organization = Organization.new(org_params)
     #@organization.save
     #redirect_to @organization
       if @organization.save
        flash[:success] = "Organization added successfully!"
        redirect_to_root_path
       else
        render :new
end
  end
   
   private
   def org_params
    #params.require(:organization).permit(:organization_name, :user_name)
    params.require(:organization).permit(:organization_name)
   end
end
