class ChangeWodDateToDatetime < ActiveRecord::Migration[6.1]
  def change
    change_column :wod_histories, :wod_date, :datetime
  end
end
