ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email

  filter :first_name
  filter :last_name
  filter :email
  filter :created_at

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :created_at
      row("Encrypted Password") { |u| u.encrypted_password }
    end

    panel "Addresses" do
      table_for user.addresses do
        column :street
        column :city
        column :postal_code
        column :province
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
    end
    f.actions
  end
end