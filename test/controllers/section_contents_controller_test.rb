require 'test_helper'

class SectionContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section_content = section_contents(:one)
  end

  test "should get index" do
    get section_contents_url
    assert_response :success
  end

  test "should get new" do
    get new_section_content_url
    assert_response :success
  end

  test "should create section_content" do
    assert_difference('SectionContent.count') do
      post section_contents_url, params: { section_content: { lesson_id: @section_content.lesson_id, section_id: @section_content.section_id } }
    end

    assert_redirected_to section_content_url(SectionContent.last)
  end

  test "should show section_content" do
    get section_content_url(@section_content)
    assert_response :success
  end

  test "should get edit" do
    get edit_section_content_url(@section_content)
    assert_response :success
  end

  test "should update section_content" do
    patch section_content_url(@section_content), params: { section_content: { lesson_id: @section_content.lesson_id, section_id: @section_content.section_id } }
    assert_redirected_to section_content_url(@section_content)
  end

  test "should destroy section_content" do
    assert_difference('SectionContent.count', -1) do
      delete section_content_url(@section_content)
    end

    assert_redirected_to section_contents_url
  end
end
