class CsvGeneratorJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    column_names = %w(name class)
    CSV.open("#{Rails.root}/public/file.csv", "wb") do |csv|
      grades = []
      csv << column_names
      User.teacher_students(user.id).each do |student|
        unless student.school_class == nil
          grades << student.name
          grades << student.school_class.name
          grades << "grades: "
          student.grades.teacher_student_grades(user.id).each do |grade|
            grades << grade.value
          end
        end
        csv << grades
        grades.clear
      end
    end
  end
end
