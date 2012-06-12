class RemoveLoginFromUser < ActiveRecord::Migration
  def up
  	remove_column :users, :login_name, :string
  end

  def down
  	add_column :users, :login_name, :string
  end
end
