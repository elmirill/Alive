class DayEntry < ApplicationRecord

  # text line desired_line check type

  belongs_to :day
  belongs_to :diary_entry

  # validates at least one attr

end