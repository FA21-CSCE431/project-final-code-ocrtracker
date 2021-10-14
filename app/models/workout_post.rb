# frozen_string_literal: true

# Workout Post
class WorkoutPost < ApplicationRecord
  has_many :exercise_posts
  has_many :workout_submissions

  validates :title, presence: true

  def ranked_exercise_post
    exercise_posts.detect(&:is_ranked)
  end

  def ranked_exercise
    ranked_exercise_post.exercise
  end

  def wod_history
    super || build_wod_history
  end

end
