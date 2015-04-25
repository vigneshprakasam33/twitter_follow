require 'test_helper'

class AutoFollowsControllerTest < ActionController::TestCase
  setup do
    @auto_follow = auto_follows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:auto_follows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create auto_follow" do
    assert_difference('AutoFollow.count') do
      post :create, auto_follow: { account_id: @auto_follow.account_id, follow_back: @auto_follow.follow_back, followed: @auto_follow.followed, follower_id: @auto_follow.follower_id }
    end

    assert_redirected_to auto_follow_path(assigns(:auto_follow))
  end

  test "should show auto_follow" do
    get :show, id: @auto_follow
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @auto_follow
    assert_response :success
  end

  test "should update auto_follow" do
    patch :update, id: @auto_follow, auto_follow: { account_id: @auto_follow.account_id, follow_back: @auto_follow.follow_back, followed: @auto_follow.followed, follower_id: @auto_follow.follower_id }
    assert_redirected_to auto_follow_path(assigns(:auto_follow))
  end

  test "should destroy auto_follow" do
    assert_difference('AutoFollow.count', -1) do
      delete :destroy, id: @auto_follow
    end

    assert_redirected_to auto_follows_path
  end
end
