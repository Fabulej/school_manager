class CreateSchoolClassSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :school_class_subjects do |t|
      t.belongs_to :school_class, index: true
      t.belongs_to :subject, index: true

      t.timestamps
    end
  end
end
