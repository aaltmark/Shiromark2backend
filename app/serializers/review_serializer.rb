class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :rating, :content, :restaurant_name, :user_name, :created_at
  
  has_many :comments 

  def restaurant_name
    self.object.restaurant.name
  end

  def user_name
    self.object.user.name
  end
end
