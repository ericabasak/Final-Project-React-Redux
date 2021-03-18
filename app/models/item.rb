class Item < ApplicationRecord
  belongs_to :list
  validates_inclusion_of :is_complete, in: [true, false]

  def to_s
    id.to_s + ' ' + name
  end
end
