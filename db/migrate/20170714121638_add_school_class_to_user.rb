class AddSchoolClassToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :school_class, foreign_key: true
  end
end
