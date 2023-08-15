class Equipment < ApplicationRecord
  
  has_one_attached :image

  # アソシエーション設定
  belongs_to :register
  has_many :change_logs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :users_equipments, through: :user_groups, dependent: :destroy
  
  # バリデーション設定
  validates :reference_number, presence: { message: "は必須項目です。" }
  validates :reference_number, uniqueness: { message: "は既に使用されています。" }
  validates :reference_number, numericality: { only_integer: true, message: "は半角数字に設定して下さい。" }
  validates :reference_number, length: { maximum: 12,  message: "は%{count}文字以下に設定して下さい。" }
  validates :introduction, presence: { message: "は必須項目です。" }
  validates :location, presence: { message: "は必須項目です。" }
  validates :name, presence: { message: "は必須項目です。" }
  validates :date, presence: { message: "は必須項目です。" }
  validates :model, presence: { message: "は必須項目です。" }

  # 抽出設定
  scope :search_name, ->(query) { where("name LIKE ?", "%#{query}%") }
  scope :search_reference_number, ->(query) { where("reference_number LIKE ?", "%#{query}%") }
  scope :search_model, ->(query) { where("model LIKE ?", "%#{query}%") }
  scope :search_location, ->(query) { where("location LIKE ?", "%#{query}%") }
  scope :search_name, ->(query) { where("name LIKE ?", "%#{query}%") }
  scope :search_date, ->(query) { where("date LIKE ?", "%#{query}%") }


  # CSVファイルをデータベースにインポートするメソッド
  def self.import(file, register_id)
    # Rooを使ってCSVファイルを読み込む
    spreadsheet = Roo::CSV.new(file.path, csv_options: { encoding: 'bom|utf-8' })
    # CSVファイルのヘッダー行を取得し、データのカラムとマッピングする
    header = spreadsheet.row(1)
    # 重複するreference_numberを格納する配列
    duplicate_reference_numbers = []
    # 2行目から最終行までを繰り返し処理
    (2..spreadsheet.last_row).each do |i|
      # 行のデータをハッシュに変換し、カラム名をキーにしてデータを取得
      row = Hash[[header, spreadsheet.row(i)].transpose]
      # データベースにidが存在する場合は既存レコードを更新、存在しない場合は新規レコードを作成
      equipment = find_by(reference_number: row['reference_number'])
      if equipment
        duplicate_reference_numbers << row['reference_number']
      else
        # 新しいequipmentオブジェクトをインスタンス化する
        equipment = new
        # CSVファイルから取得したデータをequipmentオブジェクトに設定
        equipment.attributes = row.to_hash.slice(*column_names)
        # 文字列を日付に変換して設定
        equipment.date = Date.strptime(row['date'], '%Y-%m-%d') if row['date']
        # equipmentにregister_idを設定
        equipment.register_id = register_id 
        equipment.save
      end
    end
    # error_messages # エラーメッセージの配列を返す
    if duplicate_reference_numbers.any?
      error_message = "次の管理番号は既に存在します。#{duplicate_reference_numbers.join(', ')}"
    else
      error_message = ''
    end
    error_message
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
end
