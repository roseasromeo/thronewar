require 'test_helper'

class AbilityDependenciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ability_dependency = ability_dependencies(:one)
  end

  test "should get index" do
    get ability_dependencies_url
    assert_response :success
  end

  test "should get new" do
    get new_ability_dependency_url
    assert_response :success
  end

  test "should create ability_dependency" do
    assert_difference('AbilityDependency.count') do
      post ability_dependencies_url, params: { ability_dependency: { depends_on_id: @ability_dependency.depends_on_id, parent_id: @ability_dependency.parent_id } }
    end

    assert_redirected_to ability_dependency_url(AbilityDependency.last)
  end

  test "should show ability_dependency" do
    get ability_dependency_url(@ability_dependency)
    assert_response :success
  end

  test "should get edit" do
    get edit_ability_dependency_url(@ability_dependency)
    assert_response :success
  end

  test "should update ability_dependency" do
    patch ability_dependency_url(@ability_dependency), params: { ability_dependency: { depends_on_id: @ability_dependency.depends_on_id, parent_id: @ability_dependency.parent_id } }
    assert_redirected_to ability_dependency_url(@ability_dependency)
  end

  test "should destroy ability_dependency" do
    assert_difference('AbilityDependency.count', -1) do
      delete ability_dependency_url(@ability_dependency)
    end

    assert_redirected_to ability_dependencies_url
  end
end
