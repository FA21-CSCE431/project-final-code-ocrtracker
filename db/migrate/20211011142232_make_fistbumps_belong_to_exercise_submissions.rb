# frozen_string_literal: true

class MakeFistbumpsBelongToExerciseSubmissions < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :fistbumps, :workout_submissions
    remove_reference :fistbumps, :workout_submission

    add_reference :fistbumps, :exercise_submission
    add_foreign_key :fistbumps, :exercise_submissions
  end
end
