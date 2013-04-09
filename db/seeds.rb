# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users =User.create([
 {email: 'mustermann@example.com', password: 'password', password_confirmation: 'password', firstname: 'Hans',
   lastname: 'Mustermann' }])

clients=Client.create([
 {name: 'Testclient', project: 'Testproject', created_at: '2013-03-22 12:14:13.258674', updated_at: '2013-03-22 12:14:13.258674'} ])

Work.create([
 {date: '2013-04-10', week: 15, day: 'Mittwoch', start_at: '2000-01-01 07:30:00.000000', end_at: '2000-01-01 16:00:00.000000',
  pause: '2000-01-01 00:30:00.000000', working_hours: 8.0, description: 'Test', created_at: '2013-04-09 08:41:27.812524',
  updated_at:'2013-04-09 08:41:27.812524', user_id: users.first.id, client_id: clients.first.id } ])



