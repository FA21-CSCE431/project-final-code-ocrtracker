class CreateWorkoutSubmission < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_submissions do |t|

      t.belongs_to :workout_post, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.datetime :submitted_datetime

      t.timestamps
    end
  end
end
