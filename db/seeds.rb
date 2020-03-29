# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = []
10.times do
    users<< User.new(username: Faker::Internet.username(specifier: 6), email: Faker::Internet.email, password: "password", password_confirmation: "password")
end

User.import users

lessons = []
30.times do
    #lessonss << Lesson.new(title: Faker::Markdown.headers, body: Faker::Markdown.sandwich)
    lessons << Lesson.new(title: Faker::Music.band, body: Faker::Lorem.paragraph, user_id: users.sample.id)
    lessons << Lesson.new(title: Faker::Music.instrument, body: Faker::Lorem.paragraph, user_id: users.sample.id)
    lessons << Lesson.new(title: Faker::Music.genre, body: Faker::Lorem.paragraph, user_id: users.sample.id)
end

Lesson.import lessons

sections = []


courses = []
10.times do 
    temp_course = Course.new(title: Faker::Music.genre, description: Faker::Twitter.status[:text], user_id: users.sample.id)
    #will need to connect courses to lessons once that is in place
    prev_section = nil
    
    current_section = Section.create(title: Faker::Food.dish)
    num = rand(4)
    if num == 0 
        sections << current_section
        temp_course.sections << current_section

        time = rand(6) + 1
        time.times do
            current_section.lessons << lessons.sample
        end
    end
    num.times do
        
        prev_section = current_section
        time = rand(6) + 1
        time.times do
            current_section.lessons << lessons.sample
        end
        sections << current_section
        temp_course.sections << current_section

        current_section = Section.create(title: Faker::Food.dish, previous_id: prev_section.id)
        puts current_section.id
        prev_section.next_id = current_section.id
        prev_section.save 
    end
    courses << temp_course
end

#print tests
# courses.each do |c|
#     puts c.title
#     c.sections.each do |s|
#         puts "\t#{s.title}"
#         puts "\t#{s.next_id}"
#         s.lessons.each do |l|
#             puts "\t\t#{l.title}"
#         end
#     end
#     puts ""
# end


comments = []
100.times do
    comments << Comment.new(user_id: users.sample.id, lesson_id: lessons.sample.id, text: Faker::Quote.famous_last_words)
end


#Section.import sections
Course.import courses
Comment.import comments

# tag = []
# tag << Tag.new(type: "difficulty", name: "easy"), 
#         Tag.new(type: "difficulty", name: "intermediate"),
#         Tag.new(type: "difficulty", name: "hard")
# Tag.import tag
