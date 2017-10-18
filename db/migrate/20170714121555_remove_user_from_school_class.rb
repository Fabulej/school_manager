class RemoveUserFromSchoolClass < ActiveRecord::Migration[5.1]
  def change
    remove_reference :school_classes, :user, foreign_key: true
  end
end
