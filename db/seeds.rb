# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Admin account", email: "admin@gmail.com",
  password: "admin123", is_admin: true, is_manager: true, password_confirmation: "admin123")
User.create!(name: "User account", email: "user@gmail.com",
  password: "user123", is_admin: false, is_manager: false, password_confirmation: "user123")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password)
end

10.times do |n|
  name  = "Category #{n+1}"
  Category.create!(name: name)
end

categories = Category.all
categories.each {|category| 
  5.times do
    title  = "Title #{rand 1..10 }"
    author = "Author #{rand 1..10}"
    publish_date = "2013-10-07"
    number_of_pages = rand 200..500
    avg_rate = rand 1..10
    description = Faker::Lorem.sentence 30
    category.books.create!(title: title, author: author,
      description: description, publish_date: publish_date,
      number_of_pages: number_of_pages, avg_rate: avg_rate)
  end
}
