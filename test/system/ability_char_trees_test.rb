require "application_system_test_case"

class AbilityCharTreesTest < ApplicationSystemTestCase
  setup do
    @ability_char_tree = ability_char_trees(:one)
  end

  test "visiting the index" do
    visit ability_char_trees_url
    assert_selector "h1", text: "Ability Char Trees"
  end

  test "creating a Ability char tree" do
    visit ability_char_trees_url
    click_on "New Ability Char Tree"

    fill_in "Ability", with: @ability_char_tree.ability_id
    fill_in "Char tree", with: @ability_char_tree.char_tree_id
    click_on "Create Ability char tree"

    assert_text "Ability char tree was successfully created"
    click_on "Back"
  end

  test "updating a Ability char tree" do
    visit ability_char_trees_url
    click_on "Edit", match: :first

    fill_in "Ability", with: @ability_char_tree.ability_id
    fill_in "Char tree", with: @ability_char_tree.char_tree_id
    click_on "Update Ability char tree"

    assert_text "Ability char tree was successfully updated"
    click_on "Back"
  end

  test "destroying a Ability char tree" do
    visit ability_char_trees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ability char tree was successfully destroyed"
  end
end
