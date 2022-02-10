class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  PASSWORD_FORMAT = /\A
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
  /x

  has_one :diary, dependent: :destroy

  validates :first_name, presence: true,
            length: { maximum: 100 }
  validates :last_name, presence: true,
            length: { maximum: 100 }
  validates :password,
            format: { with: PASSWORD_FORMAT, message: "must contain a digit, a lower and an upper case character" }, allow_blank: true

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end

end