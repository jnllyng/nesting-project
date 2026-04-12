class AddProvinceIdToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :province_id, :integer
  end
end
