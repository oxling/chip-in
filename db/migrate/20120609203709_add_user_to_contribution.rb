class AddUserToContribution < ActiveRecord::Migration
  def change
    add_column :contributions, :user_id, :integer
  end
end
