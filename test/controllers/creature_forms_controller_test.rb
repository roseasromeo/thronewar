require 'test_helper'

class CreatureFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @creature_form = creature_forms(:one)
  end

  test "should get index" do
    get creature_forms_url
    assert_response :success
  end

  test "should get new" do
    get new_creature_form_url
    assert_response :success
  end

  test "should create creature_form" do
    assert_difference('CreatureForm.count') do
      post creature_forms_url, params: { creature_form: { description: @creature_form.description, environment: @creature_form.environment, final_character_id: @creature_form.final_character_id, perk: @creature_form.perk } }
    end

    assert_redirected_to creature_form_url(CreatureForm.last)
  end

  test "should show creature_form" do
    get creature_form_url(@creature_form)
    assert_response :success
  end

  test "should get edit" do
    get edit_creature_form_url(@creature_form)
    assert_response :success
  end

  test "should update creature_form" do
    patch creature_form_url(@creature_form), params: { creature_form: { description: @creature_form.description, environment: @creature_form.environment, final_character_id: @creature_form.final_character_id, perk: @creature_form.perk } }
    assert_redirected_to creature_form_url(@creature_form)
  end

  test "should destroy creature_form" do
    assert_difference('CreatureForm.count', -1) do
      delete creature_form_url(@creature_form)
    end

    assert_redirected_to creature_forms_url
  end
end
