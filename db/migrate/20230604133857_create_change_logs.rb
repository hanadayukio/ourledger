class CreateChangeLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :change_logs do |t|
      
      t.integer    :equipment_id,      null: false
      t.integer    :user_id,           null: false
      t.string     :reference_number,  null: false
      t.string     :introduction,      null: false
      t.string     :location,          null: false
      t.string     :name,              null: false
      t.string     :model,             null: false
      t.string     :date,              null: false
      t.text       :notes
      t.datetime   :changed_at,       null: false

      t.timestamps
    end
  end
end
