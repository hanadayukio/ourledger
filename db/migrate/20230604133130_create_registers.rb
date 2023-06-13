class CreateRegisters < ActiveRecord::Migration[6.1]
  def change
    create_table :registers do |t|
      
      t.integer :reference_number,  null: false
      t.string  :name,             null: false
      t.text    :detail,           null: false
      t.boolean :is_deleted,       null: false, default: false

      t.timestamps
    end
  end
end
