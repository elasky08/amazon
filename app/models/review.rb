class Review < ApplicationRecord
  belongs_to :product
  validates :rating, presence: true
  has_many :likes, dependent: :destroy

  def like_for(user)
    likes.find_by_user_id user
  end

end
