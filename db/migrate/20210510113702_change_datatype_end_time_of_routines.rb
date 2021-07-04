class ChangeDatatypeEndTimeOfRoutines < ActiveRecord::Migration[6.0]
  def change
    change_column :routines, :end_time, :time
  end
end
