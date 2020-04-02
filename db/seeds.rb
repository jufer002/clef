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
sectioncontent = []
coursecontent = []
10.times do 
    temp_course = Course.new(title: Faker::Music.genre, description: Faker::Twitter.status[:text], user_id: users.sample.id)
    courses << temp_course
end



comments = []
100.times do
    comments << Comment.new(user_id: users.sample.id, lesson_id: lessons.sample.id, text: Faker::Quote.famous_last_words)
end


Course.import courses
Comment.import comments
temp = Course.all
temp.each do |c|
    prev_section = nil
    
    current_section = Section.create(title: Faker::Food.dish)
    num = rand(4)
    if num == 0 
        sections << current_section
        coursecontent << CourseContent.new(section_id: current_section.id, course_id: c.id)

        time = rand(6) + 1
        time.times do
            temp_lesson = Lesson.all.sample
            #current_section.lessons << temp_lesson
            sectioncontent << SectionContent.new(section_id: current_section.id, lesson_id: temp_lesson.id)
        end
        
    else
        num.times do
            
            prev_section = current_section
            time = rand(6) + 1
            time.times do
                temp_lesson = lessons.sample
                current_section.lessons << temp_lesson
                sectioncontent << SectionContent.new(section_id: current_section.id, lesson_id: temp_lesson.id)

            end
            sections << current_section


            current_section = Section.create(title: Faker::Food.dish, previous_id: prev_section.id)
            coursecontent << CourseContent.new(section_id: prev_section.id, course_id: c.id)
            prev_section.next_id = current_section.id
            prev_section.save 
        end
        
        
    end
end
CourseContent.import coursecontent
SectionContent.import sectioncontent


tag = []
tag << Tag.new(category: "difficulty", name: "easy")
tag << Tag.new(category: "difficulty", name: "intermediate")
tag << Tag.new(category: "difficulty", name: "hard")
Tag.import tag

lessontags = []
Lesson.all.each do |l|
    lessontags << LessonTag.new(lesson_id: l.id, tag_id: Tag.all.sample.id)
end
LessonTag.import lessontags

coursetags = []
Course.all.each do |c|
    coursetags << CourseTag.new(course_id: c.id, tag_id: Tag.all.sample.id)
end
CourseTag.import coursetags
