require "application_system_test_case"

class CourseContentsTest < ApplicationSystemTestCase
  setup do
    @course_content = course_contents(:one)
  end

  test "visiting the index" do
    visit course_contents_url
    assert_selector "h1", text: "Course Contents"
  end

  test "creating a Course content" do
    visit course_contents_url
    click_on "New Course Content"

    fill_in "Course", with: @course_content.course_id
    fill_in "Section", with: @course_content.section_id
    click_on "Create Course content"

    assert_text "Course content was successfully created"
    click_on "Back"
  end

  test "updating a Course content" do
    visit course_contents_url
    click_on "Edit", match: :first

    fill_in "Course", with: @course_content.course_id
    fill_in "Section", with: @course_content.section_id
    click_on "Update Course content"

    assert_text "Course content was successfully updated"
    click_on "Back"
  end

  test "destroying a Course content" do
    visit course_contents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course content was successfully destroyed"
  end
end
