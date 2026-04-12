class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image do |attachable|
  attachable.variant :thumb, resize_to_limit: [ 300, 300 ]
  attachable.variant :medium, resize_to_limit: [ 600, 600 ]
end
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
  [ "id", "name", "description", "price", "stock", "category_id", "on_sale", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end
end
