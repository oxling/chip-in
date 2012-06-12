class AddIsPaidToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :is_paid, :boolean
  end
end
