# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = []
10.times do
    user << User.new(username: Faker::Internet.username, email: Faker::Internet.email, password: "password", password_confirmation: "password")
end
User.import user

lesson = []
20.times do
    #lesson << Lesson.new(title: Faker::Markdown.headers, body: Faker::Markdown.sandwich)
    lesson << Lesson.new(title: Faker::Music.band, body: Faker::Markdown.sandwich, user_id: user.sample.id)
    lesson << Lesson.new(title: Faker::Music.instrument, body: Faker::Markdown.sandwich, user_id: user.sample.id)
    lesson << Lesson.new(title: Faker::Music.genre, body: Faker::Markdown.sandwich, user_id: user.sample.id)
    lesson.each do |l|
        puts l.valid?
    end
end
Lesson.import lesson

# tag = []
# tag << Tag.new(type: "difficulty", name: "easy"), 
#         Tag.new(type: "difficulty", name: "intermediate"),
#         Tag.new(type: "difficulty", name: "hard")
# Tag.import tag
