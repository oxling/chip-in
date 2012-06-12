class ContributionsController < ApplicationController
	
	before_filter :login_required
		
	before_filter :only => [ :update, :destroy ] do |controller|
		return (controller.user_owns_contribution?(params[:id]) or
					 controller.user_owns_campaign?(params[:id]))
	end
		
	def user_owns_contribution?(contribution_id)
		contribution = Contribution.find(contribution_id)
		if contribution.user == current_user
			return true
		else
			return false
		end
	end
	
	def user_owns_campaign?(contribution_id)
		contribution = Contribution.find(contribution_id)
		if contribution.campaign.user == current_user
			return true
		else
			return false
		end
	end
	
	def create
		@campaign = Campaign.find(params[:campaign_id])
		@contribution = @campaign.contributions.create()
		@contribution.amount = params[:contribution][:amount]
		@contribution.is_paid = false
		@contribution.user = current_user
		
    respond_to do |format|
      if @contribution.save
        format.html { redirect_to campaign_path(@campaign) }
        format.json { render :json => @campaign, :status => :created, :location => @campaign }
      else
        format.html { 
        	redirect_to campaign_path(@campaign), :notice => 
        	"Couldn't donate. " + @contribution.errors.full_messages.map { |msg| msg }.join(", ") + "." }
        format.json { render :json => @contribution.errors, :status => :unprocessable_entity }
      end
    end
	end
	
	def destroy
		@contribution = Contribution.find(params[:id])
		@campaign = @contribution.campaign
    @contribution.destroy

    respond_to do |format|
      format.html { redirect_to @campaign }
      format.json { head :no_content }
    end
	end
	
	def update
		@contribution = Contribution.find(params[:id])
		is_paid = params[:is_paid]
		
		#Amount and user of the contribution are immutable
		if user_owns_contribution?(params[:id]) or user_owns_campaign?(params[:id])
			@contribution.is_paid = is_paid
			@contribution.save
			redirect_to campaign_path(@contribution.campaign)
		end
	end
	
end
