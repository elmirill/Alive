class List < ApplicationRecord

  belongs_to :day
  has_many :list_items

end