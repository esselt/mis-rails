class RemoveJobsFromUploads < ActiveRecord::Migration
  def change
    remove_reference :uploads, :jobs, index: true
  end
end
