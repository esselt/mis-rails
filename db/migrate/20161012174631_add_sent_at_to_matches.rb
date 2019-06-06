class AddSentAtToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :sent_at, :datetime
  end
end
