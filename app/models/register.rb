class Register < ApplicationRecord
  
  has_many :equipments, dependent: :destroy
  
end
