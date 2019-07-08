require "application_system_test_case"

class ActiveAbilitiesTest < ApplicationSystemTestCase
  setup do
    @active_ability = active_abilities(:one)
  end

  test "visiting the index" do
    visit active_abilities_url
    assert_selector "h1", text: "Active Abilities"
  end

  test "creating a Active ability" do
    visit active_abilities_url
    click_on "New Active Ability"

    fill_in "Game ability", with: @active_ability.game_ability_id
    fill_in "Name", with: @active_ability.name
    fill_in "Rounds total", with: @active_ability.rounds_total
    click_on "Create Active ability"

    assert_text "Active ability was successfully created"
    click_on "Back"
  end

  test "updating a Active ability" do
    visit active_abilities_url
    click_on "Edit", match: :first

    fill_in "Game ability", with: @active_ability.game_ability_id
    fill_in "Name", with: @active_ability.name
    fill_in "Rounds total", with: @active_ability.rounds_total
    click_on "Update Active ability"

    assert_text "Active ability was successfully updated"
    click_on "Back"
  end

  test "destroying a Active ability" do
    visit active_abilities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Active ability was successfully destroyed"
  end
end
