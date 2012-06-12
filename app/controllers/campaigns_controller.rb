class CampaignsController < ApplicationController
	
	before_filter :login_required, :only => [:new, :create]
	
	def index
		@campaigns = Campaign.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @campaigns }
    end

	end
	
	def show
	  @campaign = Campaign.find(params[:id])
	  @users = User.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @campaign }
		end
	end
	
	def new
		@campaign = Campaign.new
	end
	
	def create
		@campaign = Campaign.new(params[:campaign])
		@campaign.user = current_user
		
		respond_to do |format|
			if @campaign.save
				format.json { render :json=> @campaign }
				format.html { redirect_to @campaign}
			else 
				format.html { render :action => "new" }
				format.json { render :json => @campaign.errors }
			end
		end
		
	end
	
end
