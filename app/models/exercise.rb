# frozen_string_literal: true

class Exercise < ApplicationRecord
  has_many :exercise_posts, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true
  validates :unit_name, presence: true
  has_one_attached :image, dependent: :destroy
  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

  enum unit_name: {
    time_l_to_h: 'Time (Lower is better)',
    time_h_to_l: 'Time (Higher is better)',
    reps: 'Reps',
    weight: 'Weight',
    sets: 'Sets',
    distance: 'Distance',
    laps: 'Laps',
    quantity: 'Quantity'
  }

  # Return the human-readable string representing unit_value. Returns 'None' if not found
  def humanized_unit_name
    self.class.unit_names.fetch(unit_name, 'None')
  end
end
