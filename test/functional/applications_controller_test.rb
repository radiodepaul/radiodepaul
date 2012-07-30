require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  setup do
    @application = applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application" do
    assert_difference('Application.count') do
      post :create, application: { anything_else: @application.anything_else, bio: @application.bio, campus_involvement: @application.campus_involvement, co_hosts: @application.co_hosts, depaul_id: @application.depaul_id, email: @application.email, experience: @application.experience, famous_person: @application.famous_person, favorite_artists: @application.favorite_artists, favorite_films: @application.favorite_films, favorite_tv_shows: @application.favorite_tv_shows, first_name: @application.first_name, gpa: @application.gpa, home_city: @application.home_city, home_state: @application.home_state, host_type: @application.host_type, influences: @application.influences, last_name: @application.last_name, major: @application.major, phone: @application.phone, podcast_topic: @application.podcast_topic, position: @application.position, show_description: @application.show_description, show_genres: @application.show_genres, show_name: @application.show_name, show_type: @application.show_type, why_depaul: @application.why_depaul, year: @application.year }
    end

    assert_redirected_to application_path(assigns(:application))
  end

  test "should show application" do
    get :show, id: @application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @application
    assert_response :success
  end

  test "should update application" do
    put :update, id: @application, application: { anything_else: @application.anything_else, bio: @application.bio, campus_involvement: @application.campus_involvement, co_hosts: @application.co_hosts, depaul_id: @application.depaul_id, email: @application.email, experience: @application.experience, famous_person: @application.famous_person, favorite_artists: @application.favorite_artists, favorite_films: @application.favorite_films, favorite_tv_shows: @application.favorite_tv_shows, first_name: @application.first_name, gpa: @application.gpa, home_city: @application.home_city, home_state: @application.home_state, host_type: @application.host_type, influences: @application.influences, last_name: @application.last_name, major: @application.major, phone: @application.phone, podcast_topic: @application.podcast_topic, position: @application.position, show_description: @application.show_description, show_genres: @application.show_genres, show_name: @application.show_name, show_type: @application.show_type, why_depaul: @application.why_depaul, year: @application.year }
    assert_redirected_to application_path(assigns(:application))
  end

  test "should destroy application" do
    assert_difference('Application.count', -1) do
      delete :destroy, id: @application
    end

    assert_redirected_to applications_path
  end
end
