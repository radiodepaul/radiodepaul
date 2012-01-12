require 'test_helper'

class HostingsControllerTest < ActionController::TestCase
  setup do
    @hosting = hostings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hostings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hosting" do
    assert_difference('Hosting.count') do
      post :create, hosting: @hosting.attributes
    end

    assert_redirected_to hosting_path(assigns(:hosting))
  end

  test "should show hosting" do
    get :show, id: @hosting.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hosting.to_param
    assert_response :success
  end

  test "should update hosting" do
    put :update, id: @hosting.to_param, hosting: @hosting.attributes
    assert_redirected_to hosting_path(assigns(:hosting))
  end

  test "should destroy hosting" do
    assert_difference('Hosting.count', -1) do
      delete :destroy, id: @hosting.to_param
    end

    assert_redirected_to hostings_path
  end
end
