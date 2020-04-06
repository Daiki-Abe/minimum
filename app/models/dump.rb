class Dump < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :goods
    validates :price
    validates :description
  end

  validates :price, numericality: {only_integer: true, message: "は半角数字で入力してください"}

  mount_uploader :image, ImageUploader
  
end
