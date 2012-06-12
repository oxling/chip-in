module CampaignsHelper

	def user_owns_campaign?(campaign)
		return (campaign.user == current_user and current_user != nil)
	end
	
end
