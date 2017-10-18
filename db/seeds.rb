Grade.destroy_all
User.destroy_all
SchoolClass.destroy_all
Subject.destroy_all

Role.find_or_create_by(name: 'admin')
Role.find_or_create_by(name: 'teacher')
Role.find_or_create_by(name: 'student')

Subject.create([{name: 'Mathematics'}, {name: 'History'}, {name: 'Information Technology'}])
SchoolClass.create([{name: 'A'}, {name: 'B'}, {name: 'C'}])
SchoolClass.first.subjects = [Subject.first, Subject.second]
SchoolClass.second.subjects = [Subject.first, Subject.third]

User.create(first_name: "Admin", last_name: "Dyrektorski", role_id: 1, email: "admin@test.pl", password: 'password', password_confirmation: 'password')

a = User.create(first_name: "Jacek", last_name: "Testowski", role_id: 3, email: "jacek@test.pl", password: 'password', password_confirmation: 'password')
b = User.create(first_name: "Placek", last_name: "Railsowy", role_id: 3, email: "placek@test.pl", password: 'password', password_confirmation: 'password')
User.create(first_name: "Balbina", last_name: "Deweloperska", role_id: 3, email: "balbina@test.pl", password: 'password', password_confirmation: 'password')

z = User.create(first_name: "John", last_name: "Doe", role_id: 2, email: "john@test.pl", password: 'password', password_confirmation: 'password')
x = User.create(first_name: "James", last_name: "Bond", role_id: 2, email: "james@test.pl", password: 'password', password_confirmation: 'password')
User.create(first_name: "Jacob", last_name: "Bocaj", role_id: 2, email: "jacob@test.pl", password: 'password', password_confirmation: 'password')

a.school_class = SchoolClass.all.first
b.school_class = SchoolClass.all.second

z.subject = Subject.all.first
x.subject = Subject.all.second

q = Grade.create(value: 2.0, description: "egzam")
w = Grade.create(value: 4.5, description: "test")
e = Grade.create(value: 3.0, description: "final exam")
r = Grade.create(value: 5.0, description: "test")

q.student = a
q.subject = Subject.all.first
w.student = a
w.subject = Subject.all.first
e.student = a
e.subject = Subject.all.second
r.student = b
r.subject = Subject.all.second

a.save
b.save
z.save
x.save
q.save
w.save
e.save
r.save
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
