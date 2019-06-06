class RemoveTypeFromUploads < ActiveRecord::Migration
  def change
    remove_column :uploads, :type, :string
  end
end
