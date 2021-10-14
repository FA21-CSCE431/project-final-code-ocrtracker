class AddWodDateToWorkoutPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :workout_posts, :wod_date, :datetime
    remove_column :workout_posts, :date_created, :date
  end
end
