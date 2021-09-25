class WorkoutPost < ApplicationRecord
    has_many :exercise_posts
    has_many :workout_submissions
    belongs_to :wod_histories
end
