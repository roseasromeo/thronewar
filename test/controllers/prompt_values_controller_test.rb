require 'test_helper'

class PromptValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prompt_value = prompt_values(:one)
  end

  test "should get index" do
    get prompt_values_url
    assert_response :success
  end

  test "should get new" do
    get new_prompt_value_url
    assert_response :success
  end

  test "should create prompt_value" do
    assert_difference('PromptValue.count') do
      post prompt_values_url, params: { prompt_value: { active_ability_id: @prompt_value.active_ability_id, prompt_id: @prompt_value.prompt_id, value: @prompt_value.value } }
    end

    assert_redirected_to prompt_value_url(PromptValue.last)
  end

  test "should show prompt_value" do
    get prompt_value_url(@prompt_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_prompt_value_url(@prompt_value)
    assert_response :success
  end

  test "should update prompt_value" do
    patch prompt_value_url(@prompt_value), params: { prompt_value: { active_ability_id: @prompt_value.active_ability_id, prompt_id: @prompt_value.prompt_id, value: @prompt_value.value } }
    assert_redirected_to prompt_value_url(@prompt_value)
  end

  test "should destroy prompt_value" do
    assert_difference('PromptValue.count', -1) do
      delete prompt_value_url(@prompt_value)
    end

    assert_redirected_to prompt_values_url
  end
end
