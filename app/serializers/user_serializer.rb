class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :location, :username
  has_many :favorites
end
