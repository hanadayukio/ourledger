class CreateChangeLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :change_logs do |t|
      
      t.integer :equipment_id,  null: false
      t.integer :user_id,       null: false
      t.string  :detail,        null: false

      t.timestamps
    end
  end
end
