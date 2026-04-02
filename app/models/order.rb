class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  belongs_to :province
  has_many :order_items
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
  ["address_id", "created_at", "gst_rate", "hst_rate", "id", "province_id", "pst_rate", "status", "total", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["address", "province", "user", "order_items", "products"]
  end
end
