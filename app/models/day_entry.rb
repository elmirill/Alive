class DayEntry < ApplicationRecord

  # text, richtext (through action_text), line, check, entry_type

  belongs_to :day
  belongs_to :diary_entry

  validates :line, length: { maximum: 255 }
  validates :rich_text, no_attachments: true

  has_rich_text :rich_text

  scope :ordered, -> { includes(:diary_entry).order("diary_entries.sort_order ASC") }
  scope :reverse_ordered, -> { includes(:diary_entry).order("diary_entries.sort_order ASC").reverse }

end