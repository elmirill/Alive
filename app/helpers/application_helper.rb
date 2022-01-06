module ApplicationHelper

  def formatted_date(date)
    date.strftime("%d.%m.%Y")
  end

  def humanized_date(date)
    date.strftime("%d %b %Y, %a")
  end

  def nav_buttons
    [
      { url: root_path, color: "amber darken-2", tooltip: "Today", icon: "today" },
      { url: days_path, color: "deep-purple lighten-1", tooltip: "Days list", icon: "view_list" },
      { url: edit_path, color: "deep-orange lighten-1", tooltip: "Edit diary", icon: "edit" },
      { url: about_path, color: "light-green", tooltip: "Tips & tricks", icon: "info" },
    ]
  end

end
