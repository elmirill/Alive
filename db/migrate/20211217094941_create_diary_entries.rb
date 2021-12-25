class CreateDiaryEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_entries do |t|
      t.string :title
      t.integer :sort_order
      t.string :entry_type
      t.belongs_to :diary

      t.timestamps
    end
  end
end