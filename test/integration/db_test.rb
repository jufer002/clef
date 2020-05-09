require 'test_helper'

class DBTest < ActionDispatch::IntegrationTest
  include SectionsHelper

  def setup
    @user = User.create(username: 'lemon', email: 'lemon@test.com', password: '123456')
    @lsn = Lesson.create(title: 'My new lesson', body: 'Learn some music!', user_id: @user.id)
    @lsn2 = Lesson.create(title: 'My new lesson 2', body: 'Learn some more music!', user_id: @user.id)
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

  test "that a user can record his progress in a course, and that progress can be undone" do
    assert Progress.new(user_id: @user.id, lesson_id: @lsn.id).save
    
    assert Progress.where(user_id: @user.id, lesson_id: @lsn.id)[0].user_id == @user.id

    assert Progress.where(user_id: @user.id, lesson_id: @lsn.id)[0].destroy
  end

  test "that completing all the lessons in a course result in a 100% completion of that course" do
    # Check 0% completion with no lessons completed
    assert add_lesson_to_section(@lsn, @sec.id)
    assert add_section_to_course(@sec, @course.id)
    assert calculate_progress(@course, @user) == 0.0

    # Check 100% completion with only one lesson
    assert Progress.new(user_id: @user.id, lesson_id: @lsn.id).save
    assert calculate_progress(@course, @user) == 1.0

    # Check 100% completion with two lessons
    assert add_lesson_to_section(@lsn2, @sec.id)
    assert Progress.new(user_id: @user.id, lesson_id: @lsn2.id).save
    assert calculate_progress(@course, @user) == 1.0

  end

  test "that a user can publish a comment" do
    @comment = Comment.new(text: "An approving comment", user_id: @user.id, lesson_id: @lsn2.id)

    assert @comment.save

    assert Comment.where(text: "An approving comment")[0].user_id == @user.id
  end
end
