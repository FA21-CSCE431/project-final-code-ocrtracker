# frozen_string_literal: true

# CreateExerciseSubmission
class CreateExerciseSubmission < ActiveRecord::Migration[6.1]
  def change
    create_table :exercise_submissions do |t|
      t.belongs_to :exercise_post, foreign_key: true
      t.belongs_to :workout_submission, foreign_key: true

      t.string :unit_value

      t.timestamps
    end
  end
end
