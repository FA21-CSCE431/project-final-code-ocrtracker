# frozen_string_literal: true

class DropLeaderboardSpot < ActiveRecord::Migration[6.1]
  def change
    drop_table :leaderboard_spots
  end
end
