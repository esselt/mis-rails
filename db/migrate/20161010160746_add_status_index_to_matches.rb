class AddStatusIndexToMatches < ActiveRecord::Migration
  def change
    add_index :matches, :status
  end
end
