class Fistbump < ApplicationRecord
    belongs_to :user
    belongs_to :workout_submission
end
