class ExercisePost < ApplicationRecord
    belongs_to :exercise
    belongs_to :workout_post
    has_many :exercise_submissions
end
