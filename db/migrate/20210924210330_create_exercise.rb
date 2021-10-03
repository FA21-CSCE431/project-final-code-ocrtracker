class CreateExercise < ActiveRecord::Migration[6.1]
  def change
    create_table :exercises do |t|
      t.text :title
      t.text :description
      t.text :picture
      t.text :unit_name

      t.timestamps
    end
  end
end
