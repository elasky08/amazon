class Product < ApplicationRecord
  has_many :users, through: :favourites
  has_many :favourites, dependent: :destroy

  belongs_to :user
  has_many :reviews, dependent: :destroy
  belongs_to :category

  validates :title, presence: true, uniqueness: {case_sensitive: false}
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 1000 }
  # validates :price, presence: true, inclusion: 1..1000 => this works too
  validates :description, presence: true, length: {minimum: 10}
  # => saying that characters must be at least 5

  scope :latest, -> {order("created_at DESC")}

  after_initialize :prices

  delegate :name, to: :category, prefix: true

  before_save :capitalize
  # def self.search(keyword)
  #   where(["title ILIKE ? OR description ILIKe ?", "%#{keyword}%", "%#{keyword}%"])
  #   # where(["title ILIKE ? ","%#{keyword}%"])
  # end
  scope :search, lambda {|keyword| where("title ILIKE ?", "%#{keyword}%") | where("description ILIKE ?", "%#{keyword}%")}

  # def self.search(str)
  #   (where("title ILIKE ?", "%#{str}%").order(title: :asc) + where("description ILIKE ?", "%#{str}%").order(description: :asc)).uniq
  # end
  self.per_page = 10
  WillPaginate.per_page = 10

  def favourite_for(user)
    favourites.find_by_user_id user
  end

  def prices
    self.price ||= 1
  end

  def capitalize
    self.title.capitalize!
  end

end
