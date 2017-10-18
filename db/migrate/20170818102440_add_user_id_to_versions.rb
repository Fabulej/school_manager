class AddUserIdToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :user_id, :integer
  end
end
