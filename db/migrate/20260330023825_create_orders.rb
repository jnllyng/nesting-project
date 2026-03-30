class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :address_id
      t.integer :province_id
      t.string :status
      t.decimal :gst_rate
      t.decimal :pst_rate
      t.decimal :hst_rate
      t.decimal :total

      t.timestamps
    end
  end
end
