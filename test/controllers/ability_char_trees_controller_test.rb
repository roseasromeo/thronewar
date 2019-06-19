require 'test_helper'

class AbilityCharTreesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ability_char_tree = ability_char_trees(:one)
  end

  test "should get index" do
    get ability_char_trees_url
    assert_response :success
  end

  test "should get new" do
    get new_ability_char_tree_url
    assert_response :success
  end

  test "should create ability_char_tree" do
    assert_difference('AbilityCharTree.count') do
      post ability_char_trees_url, params: { ability_char_tree: { ability_id: @ability_char_tree.ability_id, char_tree_id: @ability_char_tree.char_tree_id } }
    end

    assert_redirected_to ability_char_tree_url(AbilityCharTree.last)
  end

  test "should show ability_char_tree" do
    get ability_char_tree_url(@ability_char_tree)
    assert_response :success
  end

  test "should get edit" do
    get edit_ability_char_tree_url(@ability_char_tree)
    assert_response :success
  end

  test "should update ability_char_tree" do
    patch ability_char_tree_url(@ability_char_tree), params: { ability_char_tree: { ability_id: @ability_char_tree.ability_id, char_tree_id: @ability_char_tree.char_tree_id } }
    assert_redirected_to ability_char_tree_url(@ability_char_tree)
  end

  test "should destroy ability_char_tree" do
    assert_difference('AbilityCharTree.count', -1) do
      delete ability_char_tree_url(@ability_char_tree)
    end

    assert_redirected_to ability_char_trees_url
  end
end
