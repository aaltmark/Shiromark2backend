class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :rating, :content, :restaurant_id, :restaurant_name, :user_id, :user_name,  :created_at
  
  has_many :comments 

  def restaurant_name
    self.object.restaurant.name
  end

  def restaurant_id
    self.object.restaurant.id
  end

  def user_name
    self.object.user.name
  end

  def user_id
    self.object.user.id
  end

end
