class Task < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {maximum:30}
  validates :body, presence: true, length: {maximum:100}

  def self.ransackable_attributes(auth_object = nil)
    %w[title body created_at] # 検索可能な属性を設定する
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user favorite comment] # 関連モデルの検索を許可する場合は、配列に追加する
  end


  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end

