require "application_system_test_case"

class GameAbilitiesTest < ApplicationSystemTestCase
  setup do
    @game_ability = game_abilities(:one)
  end

  test "visiting the index" do
    visit game_abilities_url
    assert_selector "h1", text: "Game Abilities"
  end

  test "creating a Game ability" do
    visit game_abilities_url
    click_on "New Game Ability"

    fill_in "Ability", with: @game_ability.ability
    check "Cooldown" if @game_ability.cooldown
    check "Disruptable" if @game_ability.disruptable
    fill_in "Fate cost base", with: @game_ability.fate_cost_base
    fill_in "Fate cost function", with: @game_ability.fate_cost_function
    fill_in "Item", with: @game_ability.item
    fill_in "Long text", with: @game_ability.long_text
    fill_in "Name", with: @game_ability.name
    fill_in "Rounds base", with: @game_ability.rounds_base
    fill_in "Rounds function", with: @game_ability.rounds_function
    check "Secret action" if @game_ability.secret_action
    check "Targets another" if @game_ability.targets_another
    fill_in "Time base", with: @game_ability.time_base
    fill_in "Time function", with: @game_ability.time_function
    click_on "Create Game ability"

    assert_text "Game ability was successfully created"
    click_on "Back"
  end

  test "updating a Game ability" do
    visit game_abilities_url
    click_on "Edit", match: :first

    fill_in "Ability", with: @game_ability.ability
    check "Cooldown" if @game_ability.cooldown
    check "Disruptable" if @game_ability.disruptable
    fill_in "Fate cost base", with: @game_ability.fate_cost_base
    fill_in "Fate cost function", with: @game_ability.fate_cost_function
    fill_in "Item", with: @game_ability.item
    fill_in "Long text", with: @game_ability.long_text
    fill_in "Name", with: @game_ability.name
    fill_in "Rounds base", with: @game_ability.rounds_base
    fill_in "Rounds function", with: @game_ability.rounds_function
    check "Secret action" if @game_ability.secret_action
    check "Targets another" if @game_ability.targets_another
    fill_in "Time base", with: @game_ability.time_base
    fill_in "Time function", with: @game_ability.time_function
    click_on "Update Game ability"

    assert_text "Game ability was successfully updated"
    click_on "Back"
  end

  test "destroying a Game ability" do
    visit game_abilities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Game ability was successfully destroyed"
  end
end
