module DiaryEntryHelper

  def toggled_class(entry, value)
    "toggled" if entry.entry_type == value
  end

end