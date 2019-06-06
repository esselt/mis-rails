class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :status, null: false
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :title, null: false
      t.text :message, null: false
      t.references :jobs, null: false
      t.references :uploads

      t.timestamps null: false
    end
  end
end
