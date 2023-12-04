class ApplicationRecord < ActiveRecord::Base
  # 対応するデータベースのテーブルを用意しない
  self.abstract_class = true
end
