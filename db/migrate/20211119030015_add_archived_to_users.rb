class AddArchivedToUsers < ActiveRecord::Migration[6.1]

  def change
    add_column :users, :archived, :boolean, default: false
    add_column :workout_submissions, :archived, :boolean, default: false
  end

end
