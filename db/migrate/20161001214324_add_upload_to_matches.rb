class AddUploadToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :upload, index: true, foreign_key: true
  end
end
