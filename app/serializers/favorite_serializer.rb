class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :destination
  has_one :destination
end
