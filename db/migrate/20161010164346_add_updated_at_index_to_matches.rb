class AddUpdatedAtIndexToMatches < ActiveRecord::Migration
  def change
    add_index :matches, :updated_at
  end
end
