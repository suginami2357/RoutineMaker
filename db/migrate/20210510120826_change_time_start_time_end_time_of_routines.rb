class ChangeTimeStartTimeEndTimeOfRoutines < ActiveRecord::Migration[6.0]
  def change
    change_column :routines, :start_time, :time
    change_column :routines, :end_time, :time
  end
end
