class CreateDayEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :day_entries do |t|
      t.string :line
      t.boolean :check
      t.belongs_to :day
      t.belongs_to :diary_entry

      t.timestamps
    end
  end
end
