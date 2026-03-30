class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  belongs_to :province
  has_many :order_items
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }
end
