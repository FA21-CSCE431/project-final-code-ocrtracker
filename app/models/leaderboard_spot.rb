# frozen_string_literal: true

class LeaderboardSpot < ApplicationRecord
  belongs_to :workout_submission
end
