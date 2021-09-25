class ExercisePost < ApplicationRecord
    belongs_to :exercise
    belongs_to :workout_post
end
