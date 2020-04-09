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

  def self.set_hate_count(user)
    buys = user.buys
    buy_id = []
    buys.each do |buy|
      buy_id << buy.id
    end
    hate_count = Hate.where(buy_id: buy_id).count
  end

  def self.set_like_count(user)
    dumps = user.dumps
    dump_id = []
    dumps.each do |dump|
      dump_id << dump.id
    end
    dump_count = Like.where(dump_id: dump_id).count
  end

end
