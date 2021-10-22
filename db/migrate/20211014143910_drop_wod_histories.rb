class DropWodHistories < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :wod_histories, :workout_posts
    drop_table :wod_histories
  end
end
