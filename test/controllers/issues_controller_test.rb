require 'test_helper'

class IssuesControllerTest < ActionController::TestCase

  setup do
    @issue = issues :ls_on_atahualpa_not_well

    login
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:issues)
  end

  test 'should show issue' do
    get :show, id: @issue
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @issue
    assert_response :success
  end

  test 'should update issue' do
    patch :update, id: @issue, issue: { attr: 'value' }
    assert_redirected_to issue_url(assigns(:issue))
  end

  test 'should destroy issue' do
    assert_difference 'Issue.count', -1 do
      delete :destroy, id: @issue
    end

    assert_redirected_to issues_url
  end
end
