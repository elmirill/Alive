class DiaryEntry < ApplicationRecord

  # title, sort_order, entry_type

  after_create :create_day_entries

  belongs_to :diary
  has_many :day_entries, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :diary }
  validates :entry_type, presence: true

  protected

  def create_day_entries
    @days = self.diary.days
    @days.each do |day|
      self.day_entries.create!(day: day, type: "Day#{entry_type}")
    end
  end

end