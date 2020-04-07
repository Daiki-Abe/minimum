class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  has_many :buys, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :hates, dependent: :destroy
  has_many :dumps, dependent: :destroy
  has_many :dump_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.search(search)
    if search
      Buy.where('goods LIKE(?)', "%#{search}%")
    else
      Buy.all
    end
  end
end
