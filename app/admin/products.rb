ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :category_id, :image, :on_sale

  filter :name
  filter :price
  filter :stock
  filter :category
  filter :on_sale

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock
      f.input :on_sale
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end
end
