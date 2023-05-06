class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  def self.ransackable_attributes(auth_object = nil)
    %w[content] # 検索可能な属性を設定する
  end
end
