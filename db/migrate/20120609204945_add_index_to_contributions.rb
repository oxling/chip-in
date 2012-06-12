class AddIndexToContributions < ActiveRecord::Migration
  def change
  	    add_index :contributions, :user_id
  end
end
