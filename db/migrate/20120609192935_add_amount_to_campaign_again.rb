class AddAmountToCampaignAgain < ActiveRecord::Migration
  def change
    add_column :campaigns, :amount, :bigint
  end
end
