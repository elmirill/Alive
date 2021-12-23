class DiaryEntry < ApplicationRecord

  # title, sort_order, entry_type, desired_line

  belongs_to :diary
  has_many :day_entries, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :diary }
  validates :entry_type, presence: true

  scope :ordered, -> { order("sort_order ASC") }
  scope :reverse_ordered, -> { order("sort_order ASC").reverse }

  after_create :create_day_entries, :set_order

  protected

  def create_day_entries
    @days = self.diary.days
    @days.each do |day|
      self.day_entries.create!(day: day, type: "Day#{entry_type}")
    end
  end

  def set_order
    total_entries = self.diary.diary_entries.count
    self.update(sort_order: total_entries)
  end

end