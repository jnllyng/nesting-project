ActiveAdmin.register Province do
  permit_params :name, :gst, :pst, :hst

  index do
    selectable_column
    id_column
    column :name
    column :gst
    column :pst
    column :hst
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :gst, label: "GST (e.g. 0.05 for 5%)"
      f.input :pst, label: "PST (e.g. 0.07 for 7%)"
      f.input :hst, label: "HST (e.g. 0.13 for 13%)"
    end
    f.actions
  end
end
