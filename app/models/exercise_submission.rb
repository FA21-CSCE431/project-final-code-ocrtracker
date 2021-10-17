# frozen_string_literal: true

class ExerciseSubmission < ApplicationRecord
  belongs_to :exercise_post
  belongs_to :workout_submission
  belongs_to :user
  has_many :fistbumps, dependent: :destroy

  delegate :exercise, to: :exercise_post

  validates :unit_value, presence: true
end
