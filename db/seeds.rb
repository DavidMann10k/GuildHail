# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(name: 'Admin')
Role.create(name: 'Mod')

User.new(email: 'davidmann10k@gmail.com', password: 'please', password_confirmation: 'please', name: 'David', time_zone: 'Central Time (US & Canada)')