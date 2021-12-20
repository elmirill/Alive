class CreateDiaryItems < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_items do |t|
      t.string :title
      t.integer :sort_order
      t.belongs_to :diary

      t.timestamps
    end
  end
end
