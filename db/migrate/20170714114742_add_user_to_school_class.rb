class AddUserToSchoolClass < ActiveRecord::Migration[5.1]
  def change
    add_reference :school_classes, :user, foreign_key: true
  end
end
