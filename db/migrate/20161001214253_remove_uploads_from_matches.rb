class RemoveUploadsFromMatches < ActiveRecord::Migration
  def change
    remove_reference :matches, :uploads, index: true
  end
end
