class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.float :amount
      t.string :first_name
      t.string :last_name
      t.string :comment
      t.boolean :is_anonymous, default: false
      t.boolean :is_gift_aid, default: false

      t.integer :campaign_id

      t.timestamps
    end
  end
end
