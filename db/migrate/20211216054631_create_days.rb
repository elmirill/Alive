class CreateDays < ActiveRecord::Migration[6.1]
  def change
    create_table :days do |t|
      t.datetime :date
      t.belongs_to :diary

      t.timestamps
    end
  end
end
