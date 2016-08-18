class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true #uniqueness: {scope: :product_id}
end
