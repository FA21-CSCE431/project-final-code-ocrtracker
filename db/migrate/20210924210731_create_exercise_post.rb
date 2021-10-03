class CreateExercisePost < ActiveRecord::Migration[6.1]
  def change
    create_table :exercise_posts do |t|

      t.belongs_to :exercise, foreign_key: true
      t.belongs_to :workout_post, foreign_key: true
      t.text :specific_instructions
      t.boolean :is_ranked

      t.timestamps
    end
  end
end
