require 'test_helper'

class Story::SectionsControllerTest < ActionController::TestCase
  setup do
    @story_section = story_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:story_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create story_section" do
    assert_difference('Story::Section.count') do
      post :create, :story_section => @story_section.attributes
    end

    assert_redirected_to story_section_path(assigns(:story_section))
  end

  test "should show story_section" do
    get :show, :id => @story_section.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @story_section.to_param
    assert_response :success
  end

  test "should update story_section" do
    put :update, :id => @story_section.to_param, :story_section => @story_section.attributes
    assert_redirected_to story_section_path(assigns(:story_section))
  end

  test "should destroy story_section" do
    assert_difference('Story::Section.count', -1) do
      delete :destroy, :id => @story_section.to_param
    end

    assert_redirected_to story_sections_path
  end
end
