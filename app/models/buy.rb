class Buy < ApplicationRecord
  belongs_to :user
  has_many :buy_tags, dependent: :destroy
  has_many :tags, through: :buy_tags
  has_many :comments

  with_options presence: true do
    validates :goods
    validates :price
    validates :description
  end

  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :buy_tags, allow_destroy: true

  def self.search(search)
    if search
      Buy.where('goods LIKE(?)', "%#{search}%")
    else
      Buy.all
    end
  end

end
