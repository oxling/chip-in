class ChangeColumnOfCampaigns < ActiveRecord::Migration
  def up
  	change_column :campaigns, :amount, :decimal
  end

  def down
  	change_column :campaigns, :amount, :bigint
  end
end
