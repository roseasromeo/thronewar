require 'test_helper'

class AbilityFunctionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ability_function = ability_functions(:one)
  end

  test "should get index" do
    get ability_functions_url
    assert_response :success
  end

  test "should get new" do
    get new_ability_function_url
    assert_response :success
  end

  test "should create ability_function" do
    assert_difference('AbilityFunction.count') do
      post ability_functions_url, params: { ability_function: { name: @ability_function.name, operation: @ability_function.operation } }
    end

    assert_redirected_to ability_function_url(AbilityFunction.last)
  end

  test "should show ability_function" do
    get ability_function_url(@ability_function)
    assert_response :success
  end

  test "should get edit" do
    get edit_ability_function_url(@ability_function)
    assert_response :success
  end

  test "should update ability_function" do
    patch ability_function_url(@ability_function), params: { ability_function: { name: @ability_function.name, operation: @ability_function.operation } }
    assert_redirected_to ability_function_url(@ability_function)
  end

  test "should destroy ability_function" do
    assert_difference('AbilityFunction.count', -1) do
      delete ability_function_url(@ability_function)
    end

    assert_redirected_to ability_functions_url
  end
end
