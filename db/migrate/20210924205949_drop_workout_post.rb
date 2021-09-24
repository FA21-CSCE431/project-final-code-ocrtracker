class DropWorkoutPost < ActiveRecord::Migration[6.1]
  def up
    drop_table :workout_posts
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
