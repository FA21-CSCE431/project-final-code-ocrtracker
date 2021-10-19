# frozen_string_literal: true

class ExercisePost < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout_post
  has_many :exercise_submissions, dependent: :destroy
  validates :specific_instructions, presence: true
end
