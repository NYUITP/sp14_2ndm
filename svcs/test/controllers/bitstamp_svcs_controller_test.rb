require 'test_helper'

class BitstampSvcsControllerTest < ActionController::TestCase
  setup do
    @bitstamp_svc = bitstamp_svcs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bitstamp_svcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bitstamp_svc" do
    assert_difference('BitstampSvc.count') do
      post :create, bitstamp_svc: {  }
    end

    assert_redirected_to bitstamp_svc_path(assigns(:bitstamp_svc))
  end

  test "should show bitstamp_svc" do
    get :show, id: @bitstamp_svc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bitstamp_svc
    assert_response :success
  end

  test "should update bitstamp_svc" do
    patch :update, id: @bitstamp_svc, bitstamp_svc: {  }
    assert_redirected_to bitstamp_svc_path(assigns(:bitstamp_svc))
  end

  test "should destroy bitstamp_svc" do
    assert_difference('BitstampSvc.count', -1) do
      delete :destroy, id: @bitstamp_svc
    end

    assert_redirected_to bitstamp_svcs_path
  end
end
