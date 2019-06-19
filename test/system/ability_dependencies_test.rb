require "application_system_test_case"

class AbilityDependenciesTest < ApplicationSystemTestCase
  setup do
    @ability_dependency = ability_dependencies(:one)
  end

  test "visiting the index" do
    visit ability_dependencies_url
    assert_selector "h1", text: "Ability Dependencies"
  end

  test "creating a Ability dependency" do
    visit ability_dependencies_url
    click_on "New Ability Dependency"

    fill_in "Depends on", with: @ability_dependency.depends_on_id
    fill_in "Parent", with: @ability_dependency.parent_id
    click_on "Create Ability dependency"

    assert_text "Ability dependency was successfully created"
    click_on "Back"
  end

  test "updating a Ability dependency" do
    visit ability_dependencies_url
    click_on "Edit", match: :first

    fill_in "Depends on", with: @ability_dependency.depends_on_id
    fill_in "Parent", with: @ability_dependency.parent_id
    click_on "Update Ability dependency"

    assert_text "Ability dependency was successfully updated"
    click_on "Back"
  end

  test "destroying a Ability dependency" do
    visit ability_dependencies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ability dependency was successfully destroyed"
  end
end
