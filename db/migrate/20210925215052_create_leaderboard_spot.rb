# frozen_string_literal: true

# CreateLeaderboardSpot
class CreateLeaderboardSpot < ActiveRecord::Migration[6.1]
  def change
    create_table :leaderboard_spots do |t|
      t.belongs_to :workout_submission, foreign_key: true
      t.integer :spot_no

      t.timestamps
    end
  end
end
