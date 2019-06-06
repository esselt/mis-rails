class AddJobToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :job, index: true, foreign_key: true
  end
end
