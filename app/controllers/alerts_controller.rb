class AlertsController < InheritedResources::Base
  # POST /alerts
  # POST /alerts.json
  def create
     @alert = Alert.new(params[:alert])
     @alert.username = current_user.username
	@alert.user = current_user
     respond_to do |format|     
     if @alert.save
     # Tell the UserMailer to send a welcome email after save
     AlertMailer.alert_email(@alert, current_user).deliver
     	#redirect_to_root_path
  	format.html { redirect_to(@alert, notice: 'Alert was successfully created.') }
        format.json { render json: @alert, status: :created, location: @alert }
      else
        format.html { render action: 'new' }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end
 end

 

