class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.decimal :amount
      t.references :campaign

      t.timestamps
    end
    add_index :contributions, :campaign_id
  end
end
