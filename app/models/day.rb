class Day < ApplicationRecord

  belongs_to :dairy
  has_one :list

end