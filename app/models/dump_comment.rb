class DumpComment < ApplicationRecord
  belongs_to :user
  belongs_to :dump

  validates :text, presence: true
end
