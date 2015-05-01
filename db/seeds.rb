# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create(email: 'user1@example.com', password: 'password')
u2 = User.create(email: 'user2@example.com', password: 'password')

l1 = u1.lists.create(title: 'lista1')
u1.lists.create(title: 'lista2')
u1.lists.create(title: 'lista3')

l1.tasks.create(title: 'task1', description: 'description of task1. Lorem ipsum dolor sit amet tellus dui dui, in turpis quis ante.', date: Date.new(2015, 1, 1))
l1.tasks.create(title: 'task2', description: 'description of task2. Lorem ipsum dolor sit amet tellus dui dui, in turpis quis ante.', date: Date.new(2015, 1, 3))
l1.tasks.create(title: 'task3', description: 'description of task3. Lorem ipsum dolor sit amet tellus dui dui, in turpis quis ante.', date: Date.new(2015, 1, 2))
