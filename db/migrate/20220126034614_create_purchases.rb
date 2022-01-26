class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.string :item
      t.references :user, null: false, foreign_key: true
      t.string :url
      t.string :status
      t.string :confirm_user_id

      t.timestamps
    end
  end
end
