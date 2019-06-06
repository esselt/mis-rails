class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :type, null: false
      t.string :filename, null: false
      t.references :jobs, null: false
      t.references :invoice, index: true

      t.timestamps null: false
    end
  end
end
