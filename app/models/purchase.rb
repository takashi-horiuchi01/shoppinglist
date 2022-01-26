class Purchase < ApplicationRecord
  belongs_to :user

  validates :item, presence: true, length: { maximum: 255 }
  
end
