class RemoveNameFromUser < ActiveRecord::Migration
  def up
  	remove_column :users, :name, :string
  end

  def down
  	add_column :users, :name, :string
  end
end
