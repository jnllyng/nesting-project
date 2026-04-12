class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses
  has_many :orders
  belongs_to :province, optional: true
  validates :email, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
  [ "created_at", "email", "first_name", "id", "last_name", "updated_at" ]
  end
  def self.ransackable_associations(auth_object = nil)
  [ "addresses", "orders" ]
  end
end
