class RenameEndTimeColumnToRoutines < ActiveRecord::Migration[6.0]
  def change
    rename_column :routines, :endTime, :end_time
  end
end
