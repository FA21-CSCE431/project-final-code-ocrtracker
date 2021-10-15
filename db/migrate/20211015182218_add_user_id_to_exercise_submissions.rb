class AddUserIdToExerciseSubmissions < ActiveRecord::Migration[6.1]
  def change
    add_reference :exercise_submissions, :user
    add_foreign_key :exercise_submissions, :users
  end
end
