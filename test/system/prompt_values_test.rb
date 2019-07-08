require "application_system_test_case"

class PromptValuesTest < ApplicationSystemTestCase
  setup do
    @prompt_value = prompt_values(:one)
  end

  test "visiting the index" do
    visit prompt_values_url
    assert_selector "h1", text: "Prompt Values"
  end

  test "creating a Prompt value" do
    visit prompt_values_url
    click_on "New Prompt Value"

    fill_in "Active ability", with: @prompt_value.active_ability_id
    fill_in "Prompt", with: @prompt_value.prompt_id
    fill_in "Value", with: @prompt_value.value
    click_on "Create Prompt value"

    assert_text "Prompt value was successfully created"
    click_on "Back"
  end

  test "updating a Prompt value" do
    visit prompt_values_url
    click_on "Edit", match: :first

    fill_in "Active ability", with: @prompt_value.active_ability_id
    fill_in "Prompt", with: @prompt_value.prompt_id
    fill_in "Value", with: @prompt_value.value
    click_on "Update Prompt value"

    assert_text "Prompt value was successfully updated"
    click_on "Back"
  end

  test "destroying a Prompt value" do
    visit prompt_values_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Prompt value was successfully destroyed"
  end
end
