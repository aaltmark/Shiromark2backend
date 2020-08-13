class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :location, :image, :bio
end
