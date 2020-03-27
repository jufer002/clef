require "application_system_test_case"

class SectionContentsTest < ApplicationSystemTestCase
  setup do
    @section_content = section_contents(:one)
  end

  test "visiting the index" do
    visit section_contents_url
    assert_selector "h1", text: "Section Contents"
  end

  test "creating a Section content" do
    visit section_contents_url
    click_on "New Section Content"

    fill_in "Lesson", with: @section_content.lesson_id
    fill_in "Section", with: @section_content.section_id
    click_on "Create Section content"

    assert_text "Section content was successfully created"
    click_on "Back"
  end

  test "updating a Section content" do
    visit section_contents_url
    click_on "Edit", match: :first

    fill_in "Lesson", with: @section_content.lesson_id
    fill_in "Section", with: @section_content.section_id
    click_on "Update Section content"

    assert_text "Section content was successfully updated"
    click_on "Back"
  end

  test "destroying a Section content" do
    visit section_contents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Section content was successfully destroyed"
  end
end
