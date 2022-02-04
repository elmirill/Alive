require "bcrypt"

module TestPasswordHelper
  def default_password
    "Password111"
  end

  def default_new_password
    "Password222"
  end

  def default_invalid_password
    "pass"
  end

  def default_password_digest
    BCrypt::Password.create(default_password)
  end
end