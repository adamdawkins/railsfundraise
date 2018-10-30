class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.float :amount
      t.string :name
      t.string :comment
      t.boolean :is_anonymous, default: false

      t.integer :campaign_id

      t.timestamps
    end
  end
end
