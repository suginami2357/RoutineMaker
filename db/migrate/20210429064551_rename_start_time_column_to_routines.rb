class RenameStartTimeColumnToRoutines < ActiveRecord::Migration[6.0]
  def change
    rename_column :routines, :startTime, :start_time
  end
end
