require 'test_helper'

class Users::ImportsControllerTest < ActionController::TestCase
 setup do
    login
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create import' do
    assert_difference 'User.count' do
      assert_difference 'User.visible.count', -User.count.pred do
        post :create, import: { username: 'admin', password: 'admin123' }
        assert_response :success
        assert assigns(:imports).present?
      end
    end
  end

  test 'should not create import' do
    assert_no_difference 'User.count' do
      post :create, import: { username: 'admin', password: 'wrong' }
      assert_redirected_to new_users_import_url
    end
  end
end
