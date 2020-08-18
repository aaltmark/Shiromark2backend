class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :rating, :content, :restaurant_id, :restaurant_name, :user_id, :user_name, :user_image, :comments, :created_at
  
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

  def user_image
    self.object.user.image
  end

  def comments
    self.object.comments.map do |comment|
      user = User.find_by(id: comment.user_id)
      {
        id: comment.id,
        content: comment.content,
        created_at: comment.created_at,
        review_id: comment.review_id,
        user_id: comment.user_id,
        user_name: user.name,
        user_image: user.image
      }
    end
  end

end
