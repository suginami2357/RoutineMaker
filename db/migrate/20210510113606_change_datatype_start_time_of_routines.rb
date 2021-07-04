class ChangeDatatypeStartTimeOfRoutines < ActiveRecord::Migration[6.0]
  def change
    change_column :routines, :start_time, :time
  end
end
