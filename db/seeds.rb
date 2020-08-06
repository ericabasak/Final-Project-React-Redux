# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all;

# user1 = User.create({username: 'ericab', email: 'erica@gmail.com', password_digest: '1111'})
# user2 = User.create({username: 'adelyn', email: 'adi@gmail.com', password_digest: '2222'})
# user3 = User.create({username: 'shaan', email: 'shaan@gmail.com', password_digest: '3333'})

5.times do
  User.create({
    username: Faker::Name.first_name,
    email: Faker::String.random(length: 4),
    password_digest: Faker::Lorem.words
  })
end