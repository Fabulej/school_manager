class AddValueToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :value, :float
  end
end
