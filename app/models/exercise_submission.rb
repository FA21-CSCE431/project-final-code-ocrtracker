# frozen_string_literal: true

class ExerciseSubmission < ApplicationRecord
  belongs_to :exercise_post
  belongs_to :workout_submission
  has_many :fistbumps

  def exercise
    exercise_post.exercise
  end
  
  validates :unit_value, presence: true
end
