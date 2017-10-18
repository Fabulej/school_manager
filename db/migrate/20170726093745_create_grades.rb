class CreateGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :grades do |t|
      t.float :value
      t.text :description
      t.references :user, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
