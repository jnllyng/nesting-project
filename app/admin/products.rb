ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :image, :on_sale, category_ids: []

  filter :name
  filter :price
  filter :stock
  filter :on_sale

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock
      f.input :on_sale
      f.input :categories, as: :check_boxes, collection: Category.all
      f.input :image, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :stock
    column("Categories") { |p| p.categories.map(&:name).join(", ") }
    column :on_sale
    actions
  end
end
