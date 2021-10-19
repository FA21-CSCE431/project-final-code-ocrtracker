# frozen_string_literal: true

class AddOptOutToExerciseSubmissions < ActiveRecord::Migration[6.1]
  def change
    add_column :exercise_submissions, :opt_out, :boolean
  end
end
