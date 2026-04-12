class AddStripeChargeIdToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :stripe_charge_id, :string
  end
end
