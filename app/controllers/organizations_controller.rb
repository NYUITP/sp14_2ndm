class OrganizationsController < InheritedResources::Base
  before_filter :configure_permitted_parameters, if: :organizatios_controller?
  def new
     @organization = Organization.new(org_params)
     @organization.save
     redirect_to @organization
  end
   
   private
   def org_params
    params.require(:organization).permit(:organization_name, :user_name)
   end
end
