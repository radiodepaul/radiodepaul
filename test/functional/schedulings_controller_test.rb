require 'test_helper'

class SchedulingsControllerTest < ActionController::TestCase
  setup do
    @scheduling = schedulings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schedulings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scheduling" do
    assert_difference('Scheduling.count') do
      post :create, scheduling: @scheduling.attributes
    end

    assert_redirected_to scheduling_path(assigns(:scheduling))
  end

  test "should show scheduling" do
    get :show, id: @scheduling.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scheduling.to_param
    assert_response :success
  end

  test "should update scheduling" do
    put :update, id: @scheduling.to_param, scheduling: @scheduling.attributes
    assert_redirected_to scheduling_path(assigns(:scheduling))
  end

  test "should destroy scheduling" do
    assert_difference('Scheduling.count', -1) do
      delete :destroy, id: @scheduling.to_param
    end

    assert_redirected_to schedulings_path
  end
end
