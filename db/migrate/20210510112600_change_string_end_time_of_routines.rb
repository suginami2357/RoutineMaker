class ChangeStringEndTimeOfRoutines < ActiveRecord::Migration[6.0]
  def change
    change_column :routines, :end_time, :string
  end
end
