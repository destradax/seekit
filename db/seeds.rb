# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create(name: "Homer Simpson", email: "homer@gmail.com", password: Digest::MD5.hexdigest("homer"))
User.create(name: "Peter Griffin", email: "peter@gmail.com", password: "peter")
