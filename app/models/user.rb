class User < ApplicationRecord
  has_many :questions, dependent: :nullify
  has_many :products
  has_many :reviews
  has_many :favourites, dependent: :destroy
  has_many :favourite_products, through: :favourites, source: :product
  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

  has_secure_password

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: {case_sensitive: false}
                    # uniqueness: {case_sensitive: false},
                    # format: VALID_EMAIL_REGEX

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end

  def titleized_name
    "#{first_name.capitalize!} #{last_name.capitalize!}"
  end
end
