class User < ApplicationRecord
    has_many :favorites
    has_many :destinations, through: :favorites 
    has_many :likes
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }

    def destination_likes
        Destination.all
    end 
end
