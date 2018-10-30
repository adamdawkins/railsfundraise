class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :type
      t.integer :user_id
      t.string :slug
      t.string :title
      t.string :description
      t.date :target_date
      t.float :target

      t.timestamps
    end
  end
end
