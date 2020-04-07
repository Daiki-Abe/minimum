class Dump < ApplicationRecord
  belongs_to :user
  has_many :dump_tags, dependent: :destroy
  has_many :tags, through: :dump_tags
  has_many :dump_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  with_options presence: true do
    validates :goods
    validates :price
    validates :description
  end

  validates :price, numericality: {only_integer: true, message: "は半角数字で入力してください"}

  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :dump_tags, allow_destroy: true
  validates_associated :dump_tags, message: "を選択してください"
  validates :dump_tags, presence: true

  def self.search(search)
    if search
      Dump.where('goods LIKE(?)', "%#{search}%")
    else
      Dump.all
    end
  end
  
end
