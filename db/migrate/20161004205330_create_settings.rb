class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :version, null: false
      t.string :setting, null: false
      t.text :value, null: false

      t.timestamps null: false
    end

    add_index :settings, :setting
  end
end
