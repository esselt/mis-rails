class AddJobToUploads < ActiveRecord::Migration
  def change
    add_reference :uploads, :job, index: true, foreign_key: true
  end
end
