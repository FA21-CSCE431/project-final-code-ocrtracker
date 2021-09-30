class WorkoutPost < ApplicationRecord
    has_many :exercise_posts
    has_many :workout_submissions
    has_one :wod_history
end
