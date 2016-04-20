require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  setup do
    @issue = issues :ls_on_atahualpa_not_well
  end

  test 'blank attributes' do
    @issue.status = ''

    assert @issue.invalid?
    assert_error @issue, :status, :blank
  end

  test 'included attributes' do
    @issue.status = 'wrong'

    assert @issue.invalid?
    assert_error @issue, :status, :inclusion
  end

  test 'next status' do
    assert_equal %w(pending taken closed), @issue.next_status

    @issue.update! status: 'taken'
    assert_equal %w(taken closed), @issue.next_status

    @issue.update! status: 'closed'
    assert_equal %w(closed), @issue.next_status
  end

  test 'notify to' do
    assert_emails 1 do
      @issue.notify_to 'test@monitor.com'
    end
  end

  test 'tagged with' do
    tag    = tags :important
    issues = Issue.tagged_with tag.name

    assert_not_equal 0, issues.count
    assert_not_equal 0, issues.take.tags.count
    assert issues.all? { |issue| issue.tags.any? { |t| t.name == tag.name } }
  end

  test 'by created at' do
    skip
  end

  test 'by data' do
    skip
  end

  test 'pending?' do
    assert @issue.pending?

    @issue.status = 'taken'

    assert !@issue.pending?
  end
end
