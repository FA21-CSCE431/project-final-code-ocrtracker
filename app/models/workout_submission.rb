# frozen_string_literal: true

# Workout Submission
class WorkoutSubmission < ApplicationRecord
  belongs_to :workout_post
  belongs_to :user
  has_many :exercise_submissions, dependent: :destroy

  validates :submitted_datetime, presence: true

  def ranked_exercise_submission
    exercise_submissions.detect { |es| es.exercise_post.is_ranked }
  end

  def humanized_submitted_datetime
    submitted_datetime.strftime('%B %d at %I:%M %p')
  end
end
