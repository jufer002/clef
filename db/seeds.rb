# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = []
10.times do
    users<< User.new(username: Faker::Internet.username(specifier: 6), email: Faker::Internet.email, password: "Password123", password_confirmation: "Password123")
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

tag << Tag.new(category: "instrument", name: "guitar")
tag << Tag.new(category: "instrument", name: "piano")
tag << Tag.new(category: "instrument", name: "ukulele")
tag << Tag.new(category: "instrument", name: "trumpet")
Tag.import tag

lessontags = []
Lesson.all.each do |l|
    lessontags << LessonTag.new(lesson_id: l.id, tag_id: Tag.where(category: "difficulty").sample.id)
end
LessonTag.import lessontags

coursetags = []
Course.all.each do |c|
    coursetags << CourseTag.new(course_id: c.id, tag_id: Tag.where(category: "difficulty").sample.id)
end
CourseTag.import coursetags

#### REALISTIC SEEDS #####


mess_is_mine_body = "TODO"
mess_is_mine = Lesson.create(title: "\"Mess is Mine\" by Vance Joy", body: mess_is_mine_body, user_id: User.all.sample.id)
LessonTag.create(lesson_id: mess_is_mine.id, tag_id: Tag.where(name: "guitar").sample.id)
LessonTag.create(lesson_id: mess_is_mine.id, tag_id: Tag.where(name: "hard").sample.id)
like_gold_body = "TODO: add chords and location, and add way to pick.
        \n\n\nTime to let it go
        It won't let go of me
        Hanging by a thread
        Cutting the cord and then falling back into the
        Black 'cause if I don't
        If I wait 'til it feels right
        I'll be waiting my whole life
        Closing my eyes, remember how we were like
        Gold, when you see me
        Hi, if you need me
        Babe, that's the way it was
        That's the history
        Blue, how we used to roar
        Like an open fire
        That's the way it was
        But that's history
        Oh, oh
        That's the way it was
        But that's history
        Oh, oh
        That's the way it was
        But that's history
        I have a memory
        You're visiting me at night
        Climbing in my bed
        You were so quiet that you never woke me
        I love the way you could
        See the good in everything
        But, do we fuel the fire?
        Closing my eyes, remember how we were like
        Gold, when you see me
        Hi, if you need me
        Babe, that's the way it was
        That's the history
        Blue, how we used to roar
        Like an open fire
        That's the way it was
        But that's history
        Started with a word
        Now, look at where we are
        Everything we've done
        Is there on our faces for anyone willing to
        Read between the lines
        Now, look at where we are
        Everything we've done
        Is there on our faces for anyone willing to
        Oh, oh
        That's the way it was
        But that's history
        Oh, oh
        That's the way it was
        But that's history
        Well, I got a feeling
        Darling, it's possible that
        'Cause love's got no ceiling
        Now, that it's just so strong
        And I got a feeling
        Like everything is possible
        I'm trying to change
        Mmm
        Gold, when you see me
        Hi, if you need me
        Babe, that's the way it was
        That's the history
        Blue, how we used to roar
        Like an open fire
        That's the way it was
        But that's history
        Started with a word
        Now, look at where we are
        Everything we've done
        Is there on our faces for anyone willing to
        Read between the lines
        Now, look at where we are
        Everything we've done
        Started out with just one
        Oh
        Gold, when you see me
        Hi, if you need me
        Babe, that's the way it was
        But that's history"

like_gold = Lesson.create(title: "\"Like Gold\" by Vance Joy, with finger picking", body: like_gold_body, user_id: users.sample.id)
LessonTag.create(lesson_id: like_gold.id, tag_id: Tag.where(name: "guitar").sample.id)
LessonTag.create(lesson_id: like_gold.id, tag_id: Tag.where(name: "easy").sample.id)

saturday_sun_body = "Capo: 1st fret
                    \nStrumming Pattern: d-du-udu
                    \nStandard Tuning
                    \n\n\nSaturday Sun
                    \nC   Em        G
                    \nOh, Saturday Sun
                    \n  D   
                    \nI met someone
                    \nC           Em
                    \nOut on the West Coast
                    \nG                    D
                    \nI gotta get back, I can't let this go
                    \nC   Em        G
                    \nOh, Saturday Sun
                    \nD
                    \nI met someone
                    \nC               Em
                    \nDon't care what it costs
                    \n G         D               C    Em  G D
                    \nNo ray of sunlight's ever lost
                    
                    \n\nThe rest of the song continues with this chord pogression"


saturday_sun = Lesson.create(title: "\"Saturday Son\"", body: saturday_sun_body, user_id: users.sample.id)
LessonTag.create(lesson_id: saturday_sun.id, tag_id: Tag.where(name: "guitar").sample.id)
LessonTag.create(lesson_id: saturday_sun.id, tag_id: Tag.where(name: "easy").sample.id)

viva_la_vida_body = "Capo on the first fret and standard tuning
                    \nStrumming pattern is a bit tricky so I suggest practicing a lot before you add in the words
                    \n|   |   |   | A   A   A |   |
                    \nV   V   V   V |   |   | V   V
                    \n1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 &
                    \n\n Each chord is four beats, so switch chords by beat 5.
                    \nC is 1-4, D is 5-8, then G is 1-4 again, and Em is 5-8. Repeat for the whole song
                    I used to rule the world
Seas would rise when I gave the word
Now in the morning, I sleep alone
Sweep the streets I used to own
I used to roll the dice
Feel the fear in my enemy's eyes
Listen as the crowd would sing
Now the old king is dead! Long live the king!
One minute I held the key
Next the walls were closed on me
And I discovered that my castles stand
Upon pillars of salt and pillars of sand
I hear Jerusalem bells are ringing
Roman Cavalry choirs are singing
Be my mirror, my sword and shield
My missionaries in a foreign field
For some reason I can't explain
Once you go there was never, never a honest word
And that was when I ruled the world
It was a wicked and wild wind
Blew down the doors to let me in
Shattered windows and the sound of drums
People couldn't believe what I'd become
Revolutionaries wait
For my head on a silver plate
Just a puppet on a lonely string
Oh, who would ever want to be king?
I hear Jerusalem bells are ringing
Roman Calvary choirs are singing
Be my mirror, my sword and shield
My missionaries in a foreign field
For some reason I can't explain
I know Saint Peter won't call my name
Never an honest word
But that was when I ruled the world
Oh, oh, oh, oh, oh
I hear Jerusalem bells are ringing
Roman Calvary choirs are singing
Be my mirror, my sword and shield
My missionaries in a foreign field
For some reason I can't explain
I know Saint Peter won't call my name
Never an honest word
But that was when I ruled the world"

viva_la_vida = Lesson.create(title: "\"Viva la Vida\" by Coldplay", body: viva_la_vida_body, user_id: users.sample.id)
LessonTag.create(lesson_id: viva_la_vida.id, tag_id: Tag.where(name: "guitar").sample.id)
LessonTag.create(lesson_id: viva_la_vida.id, tag_id: Tag.where(name: "easy").sample.id)

#four cord course
myuser = User.create(username: "slammypjamas", email: "slammypjamas@gmail.com", password: "Secure135", password_confirmation: "Secure135")

four_chord = Course.create(title: "Four Chord Songs", description: "Here are songs I have compiled that only use the Em, C, G, and D chords. ", user_id: myuser.id)
CourseTag.create(course_id: four_chord.id, tag_id: Tag.where(name: "guitar").sample.id)
intro_body = "You can learn so many songs with just four chords. I have compiled a collection of songs that be played on the 
                guitar with only C, G, D, and Em. 
                TODO: teach the four chords here.
                Comment here or in the course comment section if you find more songs that can be played with these chords and I will add them."
intro = Lesson.create(title: "Four Chord Introduction", body: intro_body, user_id: myuser.id)

intro_section = Section.create(title: "Introduction to the Four Chords")
SectionContent.create(section_id: intro_section.id, lesson_id: intro.id)

vance_joy_section = Section.create(title: "Vance Joy")
SectionContent.create(section_id: vance_joy_section.id, lesson_id: mess_is_mine.id)
SectionContent.create(section_id: vance_joy_section.id, lesson_id: like_gold.id)
SectionContent.create(section_id: vance_joy_section.id, lesson_id: saturday_sun.id)

coldplay_section = Section.create(title: "Coldplay")
SectionContent.create(section_id: coldplay_section.id, lesson_id: viva_la_vida.id)

intro_section.next_id = vance_joy_section.id

vance_joy_section.previous_id = intro_section.id
vance_joy_section.next_id = coldplay_section.id

coldplay_section.previous_id = vance_joy_section.id

intro_section.save
vance_joy_section.save
coldplay_section.save

puts myuser.username
puts myuser.id
puts four_chord.title
puts four_chord.id

CourseContent.create(section_id: intro_section.id, course_id: four_chord.id)
CourseContent.create(section_id: vance_joy_section.id, course_id: four_chord.id)
CourseContent.create(section_id: coldplay_section.id, course_id: four_chord.id)


####RANDOM OTHER LESSONS#####

all_chord_body = "Once you have mastered the F chord it is simple to learn any major chord. Play the F bar chord. 
                \n\n{insert image of F chord here}\n\n
                Now move your fingers over so your index finger is on the second fret, like this. 
                \n\n{insert image of F# chord here}\n\n
                This is an F# chord. All you had to do was move your hand along the neck. Now if you move one over again, you are playing the G chord.
                Continue this process to get all the chords.\n\n
                Follow this chart to play any major chord.\n
                Index Finger Fret:  | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 | 11 | 12/0\n
                Chord               | F  | F# | G  | G# | A  | A# | B  | C  | C# | D  | D# | E\n\n
                This is with major chords. If you know how to play Bm than this can be done with minor chords too. Play the Bm
                bar chord.
                \n\n{insert image of Bm chord here}\n\n
                Now this time move your index finger from the second fret to the first fret. This is an A#m.
                \n\n{insert image of A#m chord here}\n\n
                Now if you move your hand over again so your index finger is no longer on the strings you will be playing an Am chord.
                \n\n{insert image of Am chord here}\n\n
               Using the same idea as above every minor chord can be played with this finger positions.\n\n
               Follow this chart to play any major chord.\n
               Index Finger Fret:  | 0  | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 | 11 | 12\n
               Chord               | Am | A#m| Bm | Cm | C#m| Dm | D#m| Em | Fm | F#m| Gm | G#m| Am\n\n
               
               This can be done with any bar chord. Just remember the order of the chords as you move along the neck.
               It is fairly straight fowards.
               A -> A# -> B -> C -> C# -> D -> D# -> E -> F -> F# -> G -> G# -> A again and repeat
               Notice that this is just in alphabetical order with a sharp after each letter except B and E. It is the same with minors 
               except with minor symbol after each chord. 
               Now try to play each chord From the Fm chord."
all_chords = Lesson.create(title: "Playing Every Chord With an F", body: all_chord_body, user_id: users.sample.id)
LessonTag.create(lesson_id: all_chords.id, tag_id: Tag.where(name: "guitar").sample.id)
LessonTag.create(lesson_id: all_chords.id, tag_id: Tag.where(name: "intermediate").sample.id)
Comment.create(user_id: users.sample.id, lesson_id: all_chords.id, text: "Great lesson!")
Comment.create(user_id: users.sample.id, lesson_id: all_chords.id, text: "Why is there no B# and E#?")



