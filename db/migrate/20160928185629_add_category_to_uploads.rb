class AddCategoryToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :category, :string
  end
end
