class Day < ApplicationRecord

  # date

  belongs_to :diary
  has_many :day_entries, dependent: :destroy

  validates :date, presence: true, uniqueness: { scope: :diary }

  after_create :update_day_entries

  private

  def update_day_entries
    @diary_entries = self.diary.diary_entries
    @diary_entries.each do |entry|
      self.day_entries.create!(entry_type: "Day#{entry.entry_type}", diary_entry: entry)
    end
  end

end