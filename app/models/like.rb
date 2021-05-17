class Like < ApplicationRecord
  belongs_to :user
  belongs_to :destination
  validates :user_id, uniqueness: { scope: :destination_id}
end
