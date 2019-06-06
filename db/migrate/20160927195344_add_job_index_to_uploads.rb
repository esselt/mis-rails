class AddJobIndexToUploads < ActiveRecord::Migration
  def change
    add_index :uploads, :jobs_id
  end
end
