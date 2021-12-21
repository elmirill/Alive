class Day < ApplicationRecord

  # date

  after_create :update_day_entries

  belongs_to :diary
  has_many :day_entries, dependent: :destroy

  validates :date, presence: true, uniqueness: { scope: :diary }

  private

  def update_day_entries
    @diary_entries = self.diary.diary_entries
    @diary_entries.each do |entry|
      self.day_entries.create!(type: "Day#{entry.entry_type}", diary_entry: entry)
    end
  end

end