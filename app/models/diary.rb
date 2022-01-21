class Diary < ApplicationRecord

  belongs_to :user
  has_many :diary_entries, dependent: :destroy
  has_many :days, dependent: :destroy

end