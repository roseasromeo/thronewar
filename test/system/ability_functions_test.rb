require "application_system_test_case"

class AbilityFunctionsTest < ApplicationSystemTestCase
  setup do
    @ability_function = ability_functions(:one)
  end

  test "visiting the index" do
    visit ability_functions_url
    assert_selector "h1", text: "Ability Functions"
  end

  test "creating a Ability function" do
    visit ability_functions_url
    click_on "New Ability Function"

    fill_in "Name", with: @ability_function.name
    fill_in "Operation", with: @ability_function.operation
    click_on "Create Ability function"

    assert_text "Ability function was successfully created"
    click_on "Back"
  end

  test "updating a Ability function" do
    visit ability_functions_url
    click_on "Edit", match: :first

    fill_in "Name", with: @ability_function.name
    fill_in "Operation", with: @ability_function.operation
    click_on "Update Ability function"

    assert_text "Ability function was successfully updated"
    click_on "Back"
  end

  test "destroying a Ability function" do
    visit ability_functions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ability function was successfully destroyed"
  end
end
