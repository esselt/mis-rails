class AddJobIndexToMatches < ActiveRecord::Migration
  def change
    add_index :matches, :jobs_id
  end
end
