class FixCampaigns < ActiveRecord::Migration
  def up
  	rename_column :campaigns, :owner_id, :user_id
  end

  def down
  	rename_column :campaigns, :user_id, :owner_id
  end
end
