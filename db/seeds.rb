# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create(name: "Homer Simpson", email: "homer@gmail.com", password: "homer", exp: 0)
User.create(name: "Bart Simpson", email: "bart@gmail.com", password: "bart", exp: 0)
User.create(name: "Lisa Simpson", email: "lisa@gmail.com", password: "lisa", exp: 0)
User.create(name: "Marge Simpson", email: "marge@gmail.com", password: "marge", exp: 0)
User.create(name: "Maggie Simpson", email: "maggie@gmail.com", password: "maggie", exp: 0)
User.create(name: "Peter Griffin", email: "peter@gmail.com", password: "peter", exp: 0)
User.create(name: "Lois Griffin", email: "lois@gmail.com", password: "lois", exp: 0)
User.create(name: "Stewey Griffin", email: "stewey@gmail.com", password: "stewey", exp: 0)
User.create(name: "Meg Griffin", email: "meg@gmail.com", password: "meg", exp: 0)
User.create(name: "Brian Griffin", email: "brian@gmail.com", password: "brian", exp: 0)
User.create(name: "Chris Griffin", email: "chris@gmail.com", password: "chris", exp: 0)

homer = User.find_by_email("homer@gmail.com")
peter = User.find_by_email("peter@gmail.com")
bart = User.find_by_email("bart@gmail.com")
lois = User.find_by_email("lois@gmail.com")

Friendship.delete_all
Friendship.create(user: homer, friend: peter)
Friendship.create(user: homer, friend: bart)
Friendship.create(user: peter, friend: lois)
Friendship.create(user: peter, friend: homer)
Friendship.create(user: bart, friend: lois)
Friendship.create(user: lois, friend: bart)


Quest.delete_all
Quest.create(latitude: 6.265635, longitude: -75.575016, name: "Coca-cola bridge", hint: "The coke side of life", brief: "A big company", difficulty: 2)
Quest.create(latitude: 5.936583, longitude: -72.875016, name: "Universidad Nacional", hint: "known as 'la nacho'", brief: "A big university", difficulty: 5)
Quest.create(latitude: 6.265635, longitude: -75.574016, name: "Universidad De Antioquia", hint: "known as 'la udea'", brief: "A big green university", difficulty: 3)
Quest.create(latitude: 6.265635, longitude: -75.574016, name: "Simpsons Home", hint: "742 Evergreen Terrace", brief: "The house of the yellow family", difficulty: 4)
Quest.create(latitude: 6.265635, longitude: -75.574016, name: "Griffin Home", hint: "Is in Quahog", brief: "This is where the Griffin family lives", difficulty: 1)
Quest.create(latitude: 6.169263, longitude: -75.423567, name: "Jose Maria Cordoba Airport", hint: "In Rionegro", brief: "This is an airport", difficulty: 2)

Image.delete_all
Image.create(quest_id: Quest.first.id, url: "http://placekitten.com/200/300")
Image.create(quest_id: Quest.first.id, url: "http://placekitten.com/300/200")
Image.create(quest_id: Quest.last.id, url: "http://placekitten.com/100/200")
Image.create(quest_id: Quest.last.id, url: "http://placekitten.com/200/100")

CompletedQuest.delete_all
Quest.all.each do |quest|
	CompletedQuest.create(user: homer, quest: quest)
end
CompletedQuest.create(user: bart, quest: Quest.first)
CompletedQuest.create(user: bart, quest: Quest.last)
CompletedQuest.create(user: peter, quest: Quest.first)
CompletedQuest.create(user: lois, quest: Quest.last)



