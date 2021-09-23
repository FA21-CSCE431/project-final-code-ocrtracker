class CreateWorkoutPost < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_posts do |t|

      t.belongs_to :workout, foreign_key: true
      t.datetime :date_posted
      t.boolean :is_wod
      
      t.timestamps
    end
  end
end
