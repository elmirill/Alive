class DayEntry < ApplicationRecord

  # text, line, check, type

  belongs_to :day
  belongs_to :diary_entry

  scope :ordered, -> { includes(:diary_entry).order("diary_entries.sort_order ASC") }
  scope :reverse_ordered, -> { includes(:diary_entry).order("diary_entries.sort_order ASC").reverse }

end