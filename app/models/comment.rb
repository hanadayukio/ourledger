class Comment < ApplicationRecord
  # アソシエーション設定
  belongs_to :user
  belongs_to :equipment
  
  # バリデーション設定
  validates :comment, presence: { message: "は必須項目です。" }
  validates :comment, length: { maximum: 50,  message: "は%{count}文字以下に設定して下さい。" }

  
end
