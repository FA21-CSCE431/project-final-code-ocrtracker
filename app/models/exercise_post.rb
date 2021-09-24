class ExercisePost < ApplicationRecord
    belongs_to :exercise, :workout_post
end
