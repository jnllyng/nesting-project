ActiveAdmin.register Page do
  permit_params :title, :content, :page_type

  filter :page_type
  filter :title

  form do |f|
    f.inputs do
      f.input :title
      f.input :page_type, as: :select, collection: ["about", "contact"]
      f.input :content, as: :text
    end
    f.actions
  end
end