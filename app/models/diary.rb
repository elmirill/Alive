class Diary < ApplicationRecord

  belongs_to :user
  has_many :days, dependent: :destroy
  has_many :diary_entries, dependent: :destroy
  # has_many :diary_entries, dependent: :destroy do
  #   def day_entries
  #     day_entries = []
  #     self.each do |diary_entry|
  #       diary_entry.day_entries.each do |day_entry|
  #         day_entries << day_entry
  #       end
  #     end
  #     day_entries
  #   end
  # end

  after_create :create_sample_entries, :create_today

  private

  def create_sample_entries
    titles = ["Thoughts and Insights", "Meditated", "Mood"]
    entries = titles.zip(DiaryEntry::ENTRY_TYPES)
    entries.each_with_index do |entry, i|
      self.diary_entries.create(title: entry[0], entry_type: entry[1], sort_order: i + 1)
    end
  end

  def create_today
    self.days.create(date: DateTime.current)
  end

end