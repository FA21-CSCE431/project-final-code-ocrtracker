class AddArchivedToExercises < ActiveRecord::Migration[6.1]
  def change
    add_column :exercises, :archived, :boolean, default: false
  end
end
