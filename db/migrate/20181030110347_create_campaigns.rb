class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.integer :user_id
      t.string :campaign_type
      t.string :slug
      t.string :title
      t.string :description
      t.date :target_date
      t.float :target

      t.timestamps
    end
  end
end
