class Diary < ApplicationRecord

  # belongs_to :user
  has_many :diary_items, dependent: :destroy
  has_many :days, dependent: :destroy

end