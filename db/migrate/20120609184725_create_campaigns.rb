class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.references :owner

      t.timestamps
    end
    add_index :campaigns, :owner_id
  end
end
