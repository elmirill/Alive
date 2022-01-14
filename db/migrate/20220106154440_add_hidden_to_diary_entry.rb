class AddHiddenToDiaryEntry < ActiveRecord::Migration[6.1]
  def change
    add_column :diary_entries, :hidden, :boolean
  end
end
