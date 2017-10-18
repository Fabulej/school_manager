class SchoolClass < ApplicationRecord
  has_many :students, class_name: 'User', dependent: :nullify
  has_many :school_class_subjects, dependent: :nullify
  has_many :subjects, through: :school_class_subjects

  validates_presence_of :name

end
