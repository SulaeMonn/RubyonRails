class FixColumnName1 < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :type, :role
  end
end
