# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all;
List.destroy_all;
Item.destroy_all;

5.times do

  User.create({
    username: Faker::Name.first_name,
    email: Faker::String.random(length: 4),
    password_digest: Faker::Lorem.words
  });

  List.create({
    title: Faker::Relationship.spouse,
    description: Faker::String.random,
    is_complete: Faker::Boolean.boolean
  });

  Item.create({
    name: Faker::Name.name,
    is_complete: Faker::Boolean.boolean
  });

end

