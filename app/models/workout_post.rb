class WorkoutPost < ApplicationRecord
    has_many :exercise_posts
    has_many :workout_submissions
    has_one :wod_history

    validates :title, :date_created, presence: true
end
