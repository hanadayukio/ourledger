class UsersEquipment < ApplicationRecord
  # アソシエーション設定
  belongs_to :user
  belongs_to :equipment

  
end
