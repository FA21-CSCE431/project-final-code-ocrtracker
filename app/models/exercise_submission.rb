# frozen_string_literal: true

class ExerciseSubmission < ApplicationRecord
  belongs_to :exercise_post
  belongs_to :workout_submission
  belongs_to :user
  has_many :fistbumps, dependent: :destroy

  delegate :exercise, to: :exercise_post

  validates :unit_value, presence: true

  default_scope { joins(:workout_submission).merge(WorkoutSubmission.all) }

  def humanized_unit_value
    if exercise.unit_name.starts_with?('time')
      uv = unit_value.to_f
      m = (uv / 60).to_i
      s = uv - (m * 60)
      "#{m} minutes, #{s.round(3)} seconds"
    else
      unit_value
    end
  end
end
