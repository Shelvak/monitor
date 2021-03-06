require 'test_helper'

class DashboardHelperTest < ActionView::TestCase
  test 'dashboard empty messages' do
    skip
  end

  test 'filter status' do
    assert_respond_to filter_status, :each
  end

  test 'owner options' do
    assert_respond_to owner_options, :each
  end

  test 'filter query hash' do
    assert_kind_of Hash, filter_query_hash
  end

  private


    def issue_filter
      {}
    end

    def filter_params
      {}
    end
end
