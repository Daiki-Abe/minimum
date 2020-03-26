class BuyTag < ApplicationRecord
  belongs_to :buy
  belongs_to :tag
end
