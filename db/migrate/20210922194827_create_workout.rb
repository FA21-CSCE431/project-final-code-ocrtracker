class CreateWorkout < ActiveRecord::Migration[6.1]
  def change
    create_table :workouts do |t|
      t.string :workout_title
      t.string :workout_desc
      t.string :workout_picture

      t.timestamps null:false
    end
  end
end
