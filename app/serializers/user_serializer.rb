class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :location, :image, :bio
  has_many :reviews 
end
