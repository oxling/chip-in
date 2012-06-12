module ContributionsHelper

	def user_can_update_contribution?(contribution)
		return (contribution.campaign.user == current_user or
						contribution.user == current_user)
	end

end
