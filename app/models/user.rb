class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # アソシエーション設定
  has_many :change_logs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :users_equipments, through: :user_groups, dependent: :destroy

  # バリデーション設定
  validates :code, presence: { message: "は必須項目です。" }
  validates :code, uniqueness: { message: "は既に使用されています。" }
  validates :code, numericality: { only_integer: true, message: "は半角数字に設定して下さい。" }
  validates :code, length: { maximum: 12,  message: "は%{count}文字以下に設定して下さい。" }
  validates :name, presence: { message: "は必須項目です。" }
  validates :name_kana, presence: { message: "は必須項目です。" }
  validates :name_kana,  format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: "は全角カタカナで入力してください。" }

  # 抽出設定
  scope :search_code, ->(query) { where("code LIKE ?", "%#{query}%") }
  scope :search_name, ->(query) { where("name LIKE ?", "%#{query}%") }
  scope :search_name_kana, ->(query) { where("name_kana LIKE ?", "%#{query}%") }
  scope :search_email, ->(query) { where("email LIKE ?", "%#{query}%") }
  # scope :search_name, ->(query) { where("name LIKE ?", "%#{query}%") }
  # scope :search_date, ->(query) { where("date LIKE ?", "%#{query}%") }

  
  # 現在のパスワードを入力せずにユーザーの情報を更新するメソッド
  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank? 
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end
  
  
end
