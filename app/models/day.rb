class Day < ApplicationRecord

  # date

  belongs_to :diary
  has_many :day_entries, dependent: :destroy

  validates :date, presence: true, uniqueness: { scope: :diary }

  default_scope { order("date DESC") }

  scope :reverse_ordered, -> { order("date ASC") }

  after_create :update_day_entries

  def excerpt
    excerpt_entry = get_excerpt_entry
    excerpt = excerpt_entry.rich_text.to_s.truncate(400) if excerpt_entry.present?
  end

  def excerpt?
    excerpt.present?
  end

  def excerpt_title
    excerpt_entry = get_excerpt_entry
    excerpt_entry.diary_entry.title if excerpt_entry.present?
  end

  private

  def update_day_entries
    diary_entries = self.diary.diary_entries
    diary_entries.each do |entry|
      self.day_entries.create!(entry_type: "Day#{entry.entry_type}", diary_entry: entry)
    end
  end

  def get_excerpt_entry
    day_entries = self.day_entries
    excerpt_entry = day_entries.select { |entry| entry.diary_entry.entry_type == "EntryText" && entry.rich_text.present? }.first
  end

end