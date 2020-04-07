class Tag < ApplicationRecord
  has_many :buy_tags, dependent: :destroy
  has_many :buys, through: :buy_tags
  has_many :dump_tags, dependent: :destroy
  has_many :dumps, through: :dump_tags
end
