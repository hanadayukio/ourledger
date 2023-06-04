class CreateRegisters < ActiveRecord::Migration[6.1]
  def change
    create_table :registers do |t|
      
      t.integer :refernce_number,  null: false
      t.string  :name,             null: false
      t.text    :detail,           null: false
      

      t.timestamps
    end
  end
end
