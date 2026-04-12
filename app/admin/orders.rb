ActiveAdmin.register Order do
  permit_params :status, :total, :user_id, :address_id, :province_id

  index do
    selectable_column
    id_column
    column :user
    column("Products") { |order| order.order_items.map { |i| "#{i.product.name} x#{i.quantity}" }.join(", ") }
    column("Subtotal") { |order| number_to_currency(order.order_items.sum { |i| i.item_price * i.quantity }) }
    column("GST") { |order| number_to_currency(order.order_items.sum { |i| i.item_price * i.quantity } * order.gst_rate) }
    column("PST") { |order| number_to_currency(order.order_items.sum { |i| i.item_price * i.quantity } * order.pst_rate) }
    column("HST") { |order| number_to_currency(order.order_items.sum { |i| i.item_price * i.quantity } * order.hst_rate) }
    column :total
    column :status
    column :created_at
    actions
  end

  filter :status
  filter :user
  filter :created_at

  show do
    attributes_table do
      row :id
      row :user
      row :status
      row :total
      row :address
      row :province
      row :stripe_charge_id
      row :created_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :item_price
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :status, as: :select, collection: [ "new", "paid", "shipped" ], include_blank: false
    end
    f.actions
  end
end
