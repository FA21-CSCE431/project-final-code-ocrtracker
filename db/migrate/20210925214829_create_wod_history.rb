class CreateWodHistory < ActiveRecord::Migration[6.1]
  def change
    create_table :wod_histories do |t|

      t.belongs_to :workout_post, foreign_key: true

      t.date :wod_date

      t.timestamps
    end
  end
end
