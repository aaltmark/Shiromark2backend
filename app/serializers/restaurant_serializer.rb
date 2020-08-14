class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :rating, :price, :location, :photos, :tags
  has_many :reviews 
end
