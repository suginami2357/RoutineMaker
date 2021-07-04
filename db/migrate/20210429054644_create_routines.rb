class CreateRoutines < ActiveRecord::Migration[6.0]
  def change
    create_table :routines do |t|
      t.string :content
      t.datetime :startTime
      t.datetime :endTime

      t.timestamps
    end
  end
end
