require 'test_helper'

class CharTreesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @char_tree = char_trees(:one)
  end

  test "should get index" do
    get char_trees_url
    assert_response :success
  end

  test "should get new" do
    get new_char_tree_url
    assert_response :success
  end

  test "should create char_tree" do
    assert_difference('CharTree.count') do
      post char_trees_url, params: { char_tree: { final_character_id: @char_tree.final_character_id } }
    end

    assert_redirected_to char_tree_url(CharTree.last)
  end

  test "should show char_tree" do
    get char_tree_url(@char_tree)
    assert_response :success
  end

  test "should get edit" do
    get edit_char_tree_url(@char_tree)
    assert_response :success
  end

  test "should update char_tree" do
    patch char_tree_url(@char_tree), params: { char_tree: { final_character_id: @char_tree.final_character_id } }
    assert_redirected_to char_tree_url(@char_tree)
  end

  test "should destroy char_tree" do
    assert_difference('CharTree.count', -1) do
      delete char_tree_url(@char_tree)
    end

    assert_redirected_to char_trees_url
  end
end
