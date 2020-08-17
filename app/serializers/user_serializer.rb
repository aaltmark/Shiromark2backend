class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :location, :image, :bio, :following, :followers
  has_many :reviews

  def following
    
    self.object.followed_users.map do |user|
      {
        relationship_id: self.object.active_relationships.find_by(followed_id: user.id).id,
        user_id: user.id,
        username: user.username,
        name: user.name,
        image: user.image
      }
    end
  end

  def followers
    self.object.follower_users.map do |user|
      {
        relationship_id: self.object.passive_relationships.find_by(follower_id: user.id).id,
        user_id: user.id,
        username: user.username,
        name: user.name,
        image: user.image
      }
    end
  end
end
