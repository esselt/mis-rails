class RemoveJobsFromMatches < ActiveRecord::Migration
  def change
    remove_reference :matches, :jobs, index: true
  end
end
