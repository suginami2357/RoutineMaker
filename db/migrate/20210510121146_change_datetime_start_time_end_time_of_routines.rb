class ChangeDatetimeStartTimeEndTimeOfRoutines < ActiveRecord::Migration[6.0]
  def change
    change_column :routines, :start_time, :datetime
    change_column :routines, :end_time, :datetime
  end
end
