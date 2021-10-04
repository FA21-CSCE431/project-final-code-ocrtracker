# frozen_string_literal: true

# Workout Submission
class WorkoutSubmission < ApplicationRecord
  belongs_to :workout_post
  belongs_to :user
  has_many :exercise_submissions
  has_many :fistbumps
  has_one :leaderboard_spot

  validates :submitted_datetime, presence: true

  def ranked_exercise_submission
    exercise_submissions.detect { |es| es.exercise_post.is_ranked }
  end
end
