require 'test_helper'

class AwardOrganizationsControllerTest < ActionController::TestCase
  setup do
    @award_organization = award_organizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:award_organizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create award_organization" do
    assert_difference('AwardOrganization.count') do
      post :create, award_organization: {  }
    end

    assert_redirected_to award_organization_path(assigns(:award_organization))
  end

  test "should show award_organization" do
    get :show, id: @award_organization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @award_organization
    assert_response :success
  end

  test "should update award_organization" do
    put :update, id: @award_organization, award_organization: {  }
    assert_redirected_to award_organization_path(assigns(:award_organization))
  end

  test "should destroy award_organization" do
    assert_difference('AwardOrganization.count', -1) do
      delete :destroy, id: @award_organization
    end

    assert_redirected_to award_organizations_path
  end
end
