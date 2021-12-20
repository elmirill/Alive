class DiaryItem < ApplicationRecord

  # title, sort_order

  belongs_to :diary

  validates :title, presence: true, uniqueness: { scope: :diary }

end