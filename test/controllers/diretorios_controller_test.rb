require 'test_helper'

class DiretoriosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get diretorios_index_url
    assert_response :success
  end

  test "should get new" do
    get diretorios_new_url
    assert_response :success
  end

  test "should get create" do
    get diretorios_create_url
    assert_response :success
  end

  test "should get show" do
    get diretorios_show_url
    assert_response :success
  end

  test "should get edit" do
    get diretorios_edit_url
    assert_response :success
  end

  test "should get update" do
    get diretorios_update_url
    assert_response :success
  end

  test "should get destroy" do
    get diretorios_destroy_url
    assert_response :success
  end

end
