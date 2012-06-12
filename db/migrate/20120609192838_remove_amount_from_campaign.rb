class RemoveAmountFromCampaign < ActiveRecord::Migration
  def up
    remove_column :campaigns, :amount
  end

  def down
    add_column :campaigns, :amount, :string
  end
end
