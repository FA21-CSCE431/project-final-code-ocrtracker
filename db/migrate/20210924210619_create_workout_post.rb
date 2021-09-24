class CreateWorkoutPost < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_posts do |t|

      t.text :title
      t.date :date_created

      t.timestamps
    end
  end
end
