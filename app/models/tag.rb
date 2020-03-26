class Tag < ApplicationRecord
  has_many :buy_tags, dependent: :destroy
  has_many :buys, through: :buy_tags
end
