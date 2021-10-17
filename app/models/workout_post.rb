# frozen_string_literal: true

# Workout Post
class WorkoutPost < ApplicationRecord
  has_many :exercise_posts, dependent: :destroy
  has_many :workout_submissions, dependent: :destroy

  validates :title, presence: true

  def ranked_exercise_post
    exercise_posts.detect(&:is_ranked)
  end

  def ranked_exercise
    ranked_exercise_post.exercise
  end
end
