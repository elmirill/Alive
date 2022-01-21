class User < ApplicationRecord

  EMAIL_FORMAT = /.+@.+\..+/i
  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
  /x

  has_one :diary, dependent: :destroy
  has_secure_password

  validates :first_name, presence: true,
            length: { maximum: 100 }
  validates :last_name, presence: true,
            length: { maximum: 100 }
  validates :email, presence: true,
            length: {maximum: 255},
            uniqueness: { case_sensitive: false },
            format: { with: EMAIL_FORMAT }
  validates :password,
            format: { with: PASSWORD_FORMAT, message: "must contain 8+ characters, a digit, a lower and an upper case character" }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end

end