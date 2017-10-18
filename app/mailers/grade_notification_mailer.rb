class GradeNotificationMailer < ApplicationMailer
  default from: 'popolopolopopopo@gmail.com'

  def notify_user(grade)
    @grade = grade
    mail(to: @grade.student.email, subject: "grade notification")
  end
end
