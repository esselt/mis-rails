class AddCombinedToUpload < ActiveRecord::Migration
  def change
    add_reference :uploads, :combined, index: true
  end
end
