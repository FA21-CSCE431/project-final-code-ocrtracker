# frozen_string_literal: true

class WorkoutPost < ApplicationRecord
  has_many :exercise_posts
  has_many :workout_submissions
  has_one :wod_history

  validates :title, :date_created, presence: true

  def ranked_exercise_post
    exercise_posts.detect {|ep| ep.is_ranked}
  end

  def ranked_exercise
    ranked_exercise_post.exercise
  end

end
