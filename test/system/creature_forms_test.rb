require "application_system_test_case"

class CreatureFormsTest < ApplicationSystemTestCase
  setup do
    @creature_form = creature_forms(:one)
  end

  test "visiting the index" do
    visit creature_forms_url
    assert_selector "h1", text: "Creature Forms"
  end

  test "creating a Creature form" do
    visit creature_forms_url
    click_on "New Creature Form"

    fill_in "Description", with: @creature_form.description
    fill_in "Environment", with: @creature_form.environment
    fill_in "Final character", with: @creature_form.final_character_id
    fill_in "Perk", with: @creature_form.perk
    click_on "Create Creature form"

    assert_text "Creature form was successfully created"
    click_on "Back"
  end

  test "updating a Creature form" do
    visit creature_forms_url
    click_on "Edit", match: :first

    fill_in "Description", with: @creature_form.description
    fill_in "Environment", with: @creature_form.environment
    fill_in "Final character", with: @creature_form.final_character_id
    fill_in "Perk", with: @creature_form.perk
    click_on "Update Creature form"

    assert_text "Creature form was successfully updated"
    click_on "Back"
  end

  test "destroying a Creature form" do
    visit creature_forms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Creature form was successfully destroyed"
  end
end
