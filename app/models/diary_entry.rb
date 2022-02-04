class DiaryEntry < ApplicationRecord

  # title, sort_order, entry_type

  ENTRY_TYPES = %w(EntryText EntryCheck EntryLine)

  belongs_to :diary
  has_many :day_entries, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :diary }, length: { maximum: 255 }
  validates :entry_type, presence: true, inclusion: { in: ENTRY_TYPES, message: "%{value} is not a valid entry type" }

  default_scope { order("sort_order ASC") }

  scope :reverse_ordered, -> { reorder("sort_order DESC") }

  after_create :create_day_entries, :set_order

  protected

  def create_day_entries
    days = self.diary.days
    days.each do |day|
      self.day_entries.create(day: day)
    end
  end

  def set_order
    total_entries = self.diary.diary_entries.count
    self.update(sort_order: total_entries)
  end

end