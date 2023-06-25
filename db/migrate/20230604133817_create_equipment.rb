class CreateEquipment < ActiveRecord::Migration[6.1]
  def change
    create_table :equipment do |t|
      
      t.integer :register_id,       null: false
      t.string  :reference_number,  null: false
      t.string  :introduction,      null: false
      t.string  :location,          null: false
      t.string  :name,              null: false
      t.string  :model,             null: false
      t.string  :date,              null: false
      t.text    :notes
      t.boolean :is_deleted,        null: false, default: false

      t.timestamps
    end
    
    add_foreign_key :equipment, :registers, column: :register_id
    
  end
end
