require 'test_helper'

class DBTest < ActionDispatch::IntegrationTest
  include SectionsHelper

  def setup
    @user = User.create(username: 'lemon', email: 'lemon@test.com', password: '123456')
    @lsn = Lesson.create(title: 'My new lesson', body: 'Learn some music!', user_id: @user.id)
    @sec = Section.create(title: 'My new section')
    @course = Course.create(title: 'my new course', description: 'my new course description', user_id: @user.id)
  end

  test "that a lesson can be added to a section" do
    assert add_lesson_to_section(@lsn, @sec.id)

    # Assert that the 
    assert_equal 1, @sec.lessons.length
    assert_equal @lsn, @sec.lessons.first
  end

  test "that a section can be added to a course" do
    assert add_section_to_course(@sec, @course.id)
    
    assert_equal 1, @course.sections.length
    assert_equal @sec, @course.sections.first
  end


  
end
