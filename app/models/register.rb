class Register < ApplicationRecord
  # アソシエーション設定
  has_many :equipments, dependent: :destroy
  
  # バリデーション設定
  validates :reference_number, presence: { message: "は必須項目です。" }
  validates :reference_number, uniqueness: { message: "は既に使用されています。" }
  validates :reference_number, numericality: { only_integer: true, message: "は半角数字に設定して下さい。" }
  validates :reference_number, length: { maximum: 12,  message: "は%{count}文字以下に設定して下さい。" }
  validates :name, presence: { message: "は必須項目です。" }
  validates :detail, presence: { message: "は必須項目です。" }
  validates :detail, length: { maximum: 100, message: "は%{count}文字以下に設定して下さい。" }

  # 抽出設定
  scope :search_reference_number, ->(query) { where("reference_number LIKE ?", "%#{query}%") }
  scope :search_name, ->(query) { where("name LIKE ?", "%#{query}%") }
  scope :search_detail, ->(query) { where("detail LIKE ?", "%#{query}%") }


end
