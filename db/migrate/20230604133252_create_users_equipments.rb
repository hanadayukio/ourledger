class CreateUsersEquipments < ActiveRecord::Migration[6.1]
  def change
    create_table :users_equipments do |t|
      
      t.integer :equipment_id,  null: false
      t.integer :user_id,       null: false

      t.timestamps
    end
  end
end
