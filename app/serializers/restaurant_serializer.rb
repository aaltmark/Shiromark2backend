class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :phone, :rating, :location
  has_many :reviews 
end
