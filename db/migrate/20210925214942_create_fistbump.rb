class CreateFistbump < ActiveRecord::Migration[6.1]
  def change
    create_table :fistbumps do |t|

      t.belongs_to :user, foreign_key: true
      t.belongs_to :workout_submission, foreign_key: true
      

      t.timestamps
    end
  end
end
