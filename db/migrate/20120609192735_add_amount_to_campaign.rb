class AddAmountToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :amount, :string
  end
end
