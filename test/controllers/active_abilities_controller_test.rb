require 'test_helper'

class ActiveAbilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @active_ability = active_abilities(:one)
  end

  test "should get index" do
    get active_abilities_url
    assert_response :success
  end

  test "should get new" do
    get new_active_ability_url
    assert_response :success
  end

  test "should create active_ability" do
    assert_difference('ActiveAbility.count') do
      post active_abilities_url, params: { active_ability: { game_ability_id: @active_ability.game_ability_id, name: @active_ability.name, rounds_total: @active_ability.rounds_total } }
    end

    assert_redirected_to active_ability_url(ActiveAbility.last)
  end

  test "should show active_ability" do
    get active_ability_url(@active_ability)
    assert_response :success
  end

  test "should get edit" do
    get edit_active_ability_url(@active_ability)
    assert_response :success
  end

  test "should update active_ability" do
    patch active_ability_url(@active_ability), params: { active_ability: { game_ability_id: @active_ability.game_ability_id, name: @active_ability.name, rounds_total: @active_ability.rounds_total } }
    assert_redirected_to active_ability_url(@active_ability)
  end

  test "should destroy active_ability" do
    assert_difference('ActiveAbility.count', -1) do
      delete active_ability_url(@active_ability)
    end

    assert_redirected_to active_abilities_url
  end
end
