require "application_system_test_case"

class CharTreesTest < ApplicationSystemTestCase
  setup do
    @char_tree = char_trees(:one)
  end

  test "visiting the index" do
    visit char_trees_url
    assert_selector "h1", text: "Char Trees"
  end

  test "creating a Char tree" do
    visit char_trees_url
    click_on "New Char Tree"

    fill_in "Final character", with: @char_tree.final_character_id
    click_on "Create Char tree"

    assert_text "Char tree was successfully created"
    click_on "Back"
  end

  test "updating a Char tree" do
    visit char_trees_url
    click_on "Edit", match: :first

    fill_in "Final character", with: @char_tree.final_character_id
    click_on "Update Char tree"

    assert_text "Char tree was successfully updated"
    click_on "Back"
  end

  test "destroying a Char tree" do
    visit char_trees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Char tree was successfully destroyed"
  end
end
