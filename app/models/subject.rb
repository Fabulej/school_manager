class Subject < ApplicationRecord
  has_many :school_class_subjects
  has_many :school_classes, through: :school_class_subjects
  has_one :teacher, class_name: 'User'
  has_many :grades, dependent: :delete_all

  scope :not_assigned, -> {includes(:teacher).where(users: {subject_id: nil})}

  validates_presence_of :name

end
