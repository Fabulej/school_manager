class User < ApplicationRecord
  extend Enumerize

  require 'csv'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  belongs_to :school_class
  belongs_to :subject
  has_many :grades, dependent: :nullify

  scope :admins, -> {where role_id: 1}
  scope :teachers, -> {where role_id: 2}
  scope :students, -> {where role_id: 3}
  scope :unassigned_students, -> { students.where(school_class: nil) }
  scope :teacher_students, -> (user_id) do
    where(school_class: User.find(user_id).subject.school_classes)
      .order(last_name: :asc)
  end
  validates_presence_of :first_name, :last_name
  validates :subject_id, uniqueness: true, allow_blank: true

  enumerize :role_id, in: {
    admin: 1,
    teacher: 2,
    student: 3
  }, predicates: true

  def name
  "#{first_name} #{last_name}"
  end

  def class_and_user
  "#{last_name} #{first_name}, class: #{school_class.name}"
  end
end
