class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates _user, presence: :true 
  validates :content, presence: :true 
end
