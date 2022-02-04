class Diary < ApplicationRecord

  belongs_to :user
  has_many :diary_entries, dependent: :destroy
  has_many :days, dependent: :destroy

  after_create :create_sample_entries

  private

  def create_sample_entries
    titles = ["Thoughts and Insights", "Meditated", "Mood"]
    entries = titles.zip(DiaryEntry::ENTRY_TYPES)
    entries.each_with_index do |entry, i|
      self.diary_entries.create(title: entry[0], entry_type: entry[1], sort_order: i + 1)
    end
  end

end