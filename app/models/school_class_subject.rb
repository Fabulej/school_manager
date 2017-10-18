class SchoolClassSubject < ApplicationRecord
  belongs_to :school_class
  belongs_to :subject
  accepts_nested_attributes_for :subject

  validates_uniqueness_of :school_class_id, :scope => [:subject_id]
end
