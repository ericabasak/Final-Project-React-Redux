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
    email: Faker::Internet.email,
    password_digest: Faker::Internet.password
  });

  List.create({
    title: Faker::Relationship.spouse,
    description: Faker::String.random,
    is_complete: Faker::Boolean.boolean,
    user_id: rand(1..20)
  });

  Item.create({
    name: Faker::Name.name,
    is_complete: Faker::Boolean.boolean,
    list_id: rand(1..20)
  });

end

