class Profile < ApplicationRecord
  has_many :users
  validates :description, presence: true
  validates :avatar_url, presence: true
end
