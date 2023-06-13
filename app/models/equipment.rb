class Equipment < ApplicationRecord
  
  has_one_attached :image
  
  belongs_to :register
  
end
