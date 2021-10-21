class Profile < ApplicationRecord
  belongs_to :users
  validates :description, presence: true
  validates :avatar_url, presence: true
end
