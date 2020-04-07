class DumpTag < ApplicationRecord
  belongs_to :dump
  belongs_to :tag
end
