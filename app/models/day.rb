class Day < ApplicationRecord

  belongs_to :diary

  validates :date, presence: true, uniqueness: { scope: :diary }

end