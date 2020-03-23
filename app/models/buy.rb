class Buy < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :goods
    validates :price
    validates :description
  end

  mount_uploader :image, ImageUploader

  def self.search(search)
    if search
      Buy.where('goods LIKE(?)', "%#{search}%")
    else
      Buy.all
    end
  end

end
