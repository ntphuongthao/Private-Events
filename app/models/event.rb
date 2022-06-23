class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :eventusers
  has_many :users, through: :eventusers
end