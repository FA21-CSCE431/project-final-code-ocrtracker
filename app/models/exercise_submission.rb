class ExerciseSubmission < ApplicationRecord
    belongs_to :exercise_post
    belongs_to :workout_submission
end
