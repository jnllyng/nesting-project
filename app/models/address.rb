class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  validates :street, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true, format: { with: /\A[A-Z]\d[A-Z]\s?\d[A-Z]\d\z/i }

  def self.ransackable_attributes(auth_object = nil)
    [ "city", "created_at", "id", "postal_code", "province_id", "street", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "province", "user" ]
  end

  def to_s
  "#{street}, #{city}, #{postal_code}"
  end
end
