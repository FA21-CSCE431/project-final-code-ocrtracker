class DropWorkout < ActiveRecord::Migration[6.1]
  def up
    drop_table :workouts
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
