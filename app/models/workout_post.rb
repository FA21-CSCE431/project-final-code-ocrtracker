# frozen_string_literal: true

# Workout Post
class WorkoutPost < ApplicationRecord
  has_many :exercise_posts, dependent: :destroy
  has_many :workout_submissions, dependent: :destroy

  validates :title, presence: true

  scope :current_or_past_wod, lambda {
                                where.not(wod_date: nil).where('wod_date <= ?', DateTime.now).order('wod_date DESC')
                              }

  # Give the last 10 workout posts that have been created
  scope :recent_workout_posts, lambda {
                                 limit(10).order('created_at DESC')
                               }

  def workout_submission_to_this_post_for_current_user(user)
    workout_submissions.detect { |ws| ws.user.id == user.id }
  end

  def exercise_submissions_to_this_post_for_current_user(user)
    ws = workout_submission_to_this_post_for_current_user(user)

    # If there is no workout submission to this post from user, return an empty list
    if ws.nil?
      []
    else
      ws.exercise_submissions
    end
  end

  def ranked_exercise_post
    exercise_posts.detect(&:is_ranked)
  end

  def ranked_exercise
    ranked_exercise_post.exercise
  end
end
