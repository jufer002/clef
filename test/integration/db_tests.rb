require 'test_helper'

class DBTests < ActionDispatch::IntegrationTest
  test "that a lesson can be added to a section" do
    lsn = Lesson.create(title: 'My new lesson', body: 'Learn some music!')
    
  end
end