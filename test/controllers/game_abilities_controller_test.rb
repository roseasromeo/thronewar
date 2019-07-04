require 'test_helper'

class GameAbilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_ability = game_abilities(:one)
  end

  test "should get index" do
    get game_abilities_url
    assert_response :success
  end

  test "should get new" do
    get new_game_ability_url
    assert_response :success
  end

  test "should create game_ability" do
    assert_difference('GameAbility.count') do
      post game_abilities_url, params: { game_ability: { ability: @game_ability.ability, cooldown: @game_ability.cooldown, disruptable: @game_ability.disruptable, fate_cost_base: @game_ability.fate_cost_base, fate_cost_function: @game_ability.fate_cost_function, item: @game_ability.item, long_text: @game_ability.long_text, name: @game_ability.name, rounds_base: @game_ability.rounds_base, rounds_function: @game_ability.rounds_function, secret_action: @game_ability.secret_action, targets_another: @game_ability.targets_another, time_base: @game_ability.time_base, time_function: @game_ability.time_function } }
    end

    assert_redirected_to game_ability_url(GameAbility.last)
  end

  test "should show game_ability" do
    get game_ability_url(@game_ability)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_ability_url(@game_ability)
    assert_response :success
  end

  test "should update game_ability" do
    patch game_ability_url(@game_ability), params: { game_ability: { ability: @game_ability.ability, cooldown: @game_ability.cooldown, disruptable: @game_ability.disruptable, fate_cost_base: @game_ability.fate_cost_base, fate_cost_function: @game_ability.fate_cost_function, item: @game_ability.item, long_text: @game_ability.long_text, name: @game_ability.name, rounds_base: @game_ability.rounds_base, rounds_function: @game_ability.rounds_function, secret_action: @game_ability.secret_action, targets_another: @game_ability.targets_another, time_base: @game_ability.time_base, time_function: @game_ability.time_function } }
    assert_redirected_to game_ability_url(@game_ability)
  end

  test "should destroy game_ability" do
    assert_difference('GameAbility.count', -1) do
      delete game_ability_url(@game_ability)
    end

    assert_redirected_to game_abilities_url
  end
end
