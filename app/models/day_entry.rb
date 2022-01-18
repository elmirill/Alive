class DayEntry < ApplicationRecord

  # richtext (through action_text), line, check

  # TODO: define entry type from the diary entry -- it'll help optimizing DB requests
  belongs_to :day
  belongs_to :diary_entry

  validates :line, length: { maximum: 255 }
  validates :rich_text, no_attachments: true

  delegate :diary, to: :diary_entry
  delegate :entry_type, to: :diary_entry

  has_rich_text :rich_text

  default_scope { includes(:diary_entry).order("diary_entries.sort_order ASC") }

  scope :reverse_ordered, -> { includes(:diary_entry).order("diary_entries.sort_order ASC").reverse }

end