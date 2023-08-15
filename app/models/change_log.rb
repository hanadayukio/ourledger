class ChangeLog < ApplicationRecord
  # アソシエーション設定
  belongs_to :user
  belongs_to :equipment
  
    # 抽出設定
  scope :search_reference_number, ->(query) { where("reference_number LIKE ?", "%#{query}%") }
  scope :search_introduction, ->(query) { where("introduction LIKE ?", "%#{query}%") }
  scope :search_location, ->(query) { where("location LIKE ?", "%#{query}%") }
  scope :search_name, ->(query) { where("name LIKE ?", "%#{query}%") }
  scope :search_model, ->(query) { where("model LIKE ?", "%#{query}%") }
  scope :search_date, ->(query) { where("date LIKE ?", "%#{query}%") }
  scope :search_notes, ->(query) { where("notes LIKE ?", "%#{query}%") }
  scope :search_user, ->(query) { joins(:user).where("users.name LIKE ?", "%#{query}%") }

  
end