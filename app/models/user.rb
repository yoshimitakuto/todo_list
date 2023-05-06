class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #follower_id : フォローしたユーザー
  #followed_id : フォローされたユーザー

  #フォローする側、される側の関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id",  dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  #一覧表示のための実装
  #ユーザーがフォローしている人（あるユーザーにフォローされたユーザー）全員をとってくる
  has_many :followings, through: :relationships, source: :followed
  #ユーザーをフォローしている人（あるユーザーをフォローしたユーザー）全員をとってくる
  has_many :followers, through: :reverse_of_relationships, source: :follower

  #relationshipsのメソッド
  # フォローした時
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  #フォローを外す時
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  #フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name] # 検索可能な属性を設定する
  end

  has_one_attached :profile_image

  validates :name, presence: true

def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
end

def already_favorited?(task)
  self.favorites.exists?(task_id: task.id)
end

end
