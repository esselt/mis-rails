class ChangeCategoryNotNullInUploads < ActiveRecord::Migration
  def change
    change_column :uploads, :category, :string, null: false
  end
end
