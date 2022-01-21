module ApplicationHelper
  require 'net/http'
  require 'uri'

  def formatted_date(date)
    date.strftime("%d.%m.%Y")
  end

  def humanized_date(date)
    date.strftime("%d %b %Y")
  end

  def humanized_date_with_weekday(date)
    date.strftime("%d %b %Y, %a")
  end

  def weekday(date)
    date.strftime("%a")
  end

  def logged_in_nav_buttons
    [
      { url: settings_path, class: "blue base hide-on-med-and-up", tooltip: "Settings", image: user_icon(@current_user) },
      { url: root_path, class: "amber darken-2", tooltip: "Today", icon: "today" },
      { url: days_path, class: "deep-purple lighten-1", tooltip: "Days list", icon: "view_list" },
      { url: edit_diary_path, class: "deep-orange lighten-1", tooltip: "Edit diary", icon: "edit" },
      { url: about_path, class: "light-green darken-1", tooltip: "About", icon: "info" }
    ]
  end

  def logged_out_nav_buttons
    [
      { url: signup_path, class: "light-green darken-1", tooltip: "Sign up", icon: "person_add" },
      { url: signin_path, class: "deep-purple lighten-1", tooltip: "Sign in", icon: "person" }
    ]
  end

  def nav_buttons
    if current_user?
      logged_in_nav_buttons
    else
      logged_out_nav_buttons
    end
  end

  def user_icon(user)
    hash = Digest::MD5.hexdigest(user.email)
    # hash = "dgkldflgk"
    url = "https://www.gravatar.com/avatar/#{hash}?d=404"
    response = Net::HTTP.get_response(URI(url))
    code = response.code.to_i
    unless code == 404
      image_tag(url, alt: user.first_name)
    else
      material_icon.settings
    end
  end

  def classify(entry)
    entry.underscore.dasherize
  end

end
