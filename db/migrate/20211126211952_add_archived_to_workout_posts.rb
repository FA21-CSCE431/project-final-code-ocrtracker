class AddArchivedToWorkoutPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :workout_posts, :archived, :boolean, default: false
  end
end
