class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :description, :us, :airport_code, :photos, :rating, :reviews, :user_ratings_total
  has_many :likes
end
