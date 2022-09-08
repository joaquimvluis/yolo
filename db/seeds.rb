# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"

UserTask.destroy_all
Task.destroy_all
ExperienceCategory.destroy_all
User.destroy_all
Experience.destroy_all
Category.destroy_all

puts "deleted the previous records"


# --------------------USERS---------------------------------------

puts 'Creating 10 fake users...'
10.times do
  file = URI.open("https://source.unsplash.com/random/?user")
  user = User.new(
    email: Faker::Internet.email,
    password: '123456',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.birthday(min_age: 18),
    bio: Faker::Hipster.words(number: 3)
  )
  user.photo.attach(io: file, filename: "user.png", content_type: "image/png")
  user.save!
end
puts '10 Users have been created!'

# --------------------CATEGORIES---------------------------------------

puts 'Creating 5 categories...'
categories = ['Wildlife', 'Culture', 'Outdoors', 'Romance', 'Food']
# filepath_category = "db/experiencecategory.txt"
# category = File.read(filepath_category).split("\n")
5.times do |index|
  category = Category.new(
    name: categories[index],
  )
  category.save!
end
puts '5 Categories have been created!'

# --------------------EXPERIENCES---------------------------------------

puts 'Creating 30 experiences...'

filepath_title = "db/experiencetitle.txt"
title = File.read(filepath_title).split("\n")

filepath_picture = "db/experiencepicture.txt"
picture = File.read(filepath_picture).split("\n")

filepath_description = "db/experiencedescription.txt"
description = File.read(filepath_description).split("\n")


30.times do |index|
  file = URI.open(picture[index])

  experience = Experience.new(
    title: title[index],
    description: description[index],
  )
  experience.photo.attach(io: file, filename: "experience.png", content_type: "image/png")
  experience.save!
end

puts '30 experiences have been created!'

# --------------------EXPERIENCE_CATEGORIES---------------------------------------

filepath_category = "db/experiencecategory.txt"
category2 = File.read(filepath_category).split("\n")

filepath_title = "db/experiencetitle.txt"
title = File.read(filepath_title).split("\n")

20.times do |index|
  category = ExperienceCategory.new
  category.experience = Experience.find_by(title: title[index])
  category.category = Category.find_by(name: category2[index])
  category.save!
end

# --------------------USER TASKS---------------------------------------
