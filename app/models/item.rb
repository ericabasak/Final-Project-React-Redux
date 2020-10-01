class Item < ApplicationRecord
  belongs_to :list

  def to_s
    id.to_s + ' ' + name
  end
end
