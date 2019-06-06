class ChangeJobInMatches < ActiveRecord::Migration
  def change
    change_column :matches, :job_id, :integer, null: false
  end
end
