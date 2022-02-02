class Purchase < ApplicationRecord
  belongs_to :user

  validates :item, presence: true, length: { maximum: 255 }
  validates :url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
end
