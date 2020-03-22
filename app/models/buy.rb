class Buy < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :goods
    validates :price
    validates :description
  end

  mount_uploader :image, ImageUploader
end
