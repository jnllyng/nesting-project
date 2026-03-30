class Page < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :page_type, presence: true, inclusion: { in: [ "about", "contact" ] }

  def self.ransackable_attributes(auth_object = nil)
    [ "content", "created_at", "id", "page_type", "title", "updated_at" ]
  end
end
