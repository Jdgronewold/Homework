class Route < ApplicationRecord

  validates :user_id, uniqueness: true

  belongs_to :user,
    foreign_key: :user_id,
    class_name: :User
end
