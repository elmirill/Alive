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
      { url: settings_path, id: "settings-button", name: "settings", class: "blue base hide-on-med-and-up", tooltip: "Settings", image: user_icon(@current_user) },
      { url: today_path, id: "today-button", name: "today", class: "amber darken-2", tooltip: "Today", icon: "today" },
      { url: days_path, id: "days-button", name: "days", class: "deep-purple lighten-1", tooltip: "Days list", icon: "view_list" },
      { url: edit_diary_path, id: "edit-diary-button", name: "edit-diary", class: "deep-orange lighten-1", tooltip: "Edit diary", icon: "edit" },
      { url: about_path, id: "about-button", name: "about", class: "light-green darken-1", tooltip: "About", icon: "info" }
    ]
  end

  def logged_out_nav_buttons
    [
      { url: signup_path, id: "signup-button", name: "sign-in", class: "light-green darken-1", tooltip: "Sign up", icon: "person_add" },
      { url: signin_path, id: "signin-button", name: "sign-up", class: "deep-purple lighten-1", tooltip: "Sign in", icon: "person" }
    ]
  end

  def nav_buttons
    if user_signed_in?
      logged_in_nav_buttons
    else
      logged_out_nav_buttons
    end
  end

  def user_icon(user)
    hash = Digest::MD5.hexdigest(user.email)
    # hash = "invalid_hash"
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

  # Devise helpers
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
