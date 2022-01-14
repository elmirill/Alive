class RenameDayEntriesTypeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :day_entries, :type, :entry_type
  end
end
