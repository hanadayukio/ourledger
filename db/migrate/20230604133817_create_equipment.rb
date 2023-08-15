class CreateEquipment < ActiveRecord::Migration[6.1]
  def change
    create_table :equipment do |t|
      
      t.integer :register_id,       null: false
      t.integer  :reference_number, null: false
      t.string  :introduction,      null: false
      t.string  :location,          null: false
      t.string  :name,              null: false
      t.string  :model,             null: false
      t.date  :date,                null: false
      t.text    :notes
      t.boolean :is_deleted,        null: false, default: false
      # 楽観的ロック
      t.integer :lock_version, default: 0
     
      t.timestamps
    end
    
    add_foreign_key :equipment, :registers, column: :register_id
    
  end
end
