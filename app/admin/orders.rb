ActiveAdmin.register Order do
  permit_params :status, :total, :user_id, :address_id, :province_id

  index do
    selectable_column
    id_column
    column :user
    column :status
    column :total
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
