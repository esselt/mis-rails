class ChangeUploadInMatches < ActiveRecord::Migration
  def change
    change_column :matches, :upload_id, :integer, null: false
  end
end
