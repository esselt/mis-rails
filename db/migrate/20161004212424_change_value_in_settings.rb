class ChangeValueInSettings < ActiveRecord::Migration
  def change
    change_column :settings, :value, :text, null: true
  end
end
