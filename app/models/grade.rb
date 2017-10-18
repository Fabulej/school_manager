class Grade < ApplicationRecord
  belongs_to :student, class_name: 'User', foreign_key: 'user_id'
  belongs_to :subject

  has_paper_trail meta: {user_id: :user_id,
                         value: :value,
                         description: :description}

  scope :teacher_student_grades, -> (user_id) do
    where(subject_id: User.find(user_id).subject_id)
  end
  
  scope :student_subject_grades, -> (subject_id, user_id) do
    where(subject_id: subject_id).where(user_id: user_id)
  end

  ALLOWED_VALUES = [
    2,
    3,
    3.5,
    4,
    4.5,
    5
  ]

  validates :value, inclusion: { in: ALLOWED_VALUES }

end
