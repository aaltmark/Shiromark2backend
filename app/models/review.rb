class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :comments, dependent: :destroy

  validates :user, presence: :true
  validates :restaurant, presence: :true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  validates :content, presence: :true

  # validates_uniqueness_of :user_id, :scope => :restaurant_id, message: "| You've already left a review for this restaurant."

end
