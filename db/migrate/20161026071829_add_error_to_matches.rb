class AddErrorToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :error, :string
  end
end
