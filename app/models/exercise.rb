# frozen_string_literal: true

class Exercise < ApplicationRecord
  has_many :exercise_posts, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true
  validates :unit_name, presence: true
end
