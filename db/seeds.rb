# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create(name: "Homer Simpson", email: "homer@gmail.com", password: Digest::MD5.hexdigest("homer"), exp: 0)
User.create(name: "Peter Griffin", email: "peter@gmail.com", password: "peter", exp: 0)

Quest.delete_all
Quest.create(latitude: 6.265635, longitude: -75.575016, name: "Coca-cola bridge", hint: "The coke side of life", brief: "A big company", difficulty: 2)
Quest.create(latitude: 5.936583, longitude: -72.875016, name: "Universidad Nacional", hint: "known as 'la nacho'", brief: "A big university", difficulty: 5)
Quest.create(latitude: 6.265635, longitude: -75.574016, name: "Universidad De Antioquia", hint: "known as 'la udea'", brief: "A big green university", difficulty: 3)



