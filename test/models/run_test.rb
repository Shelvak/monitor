require 'test_helper'

class RunTest < ActiveSupport::TestCase
  setup do
    @run = runs :ls_on_atahualpa
  end

  test 'blank attributes' do
    @run.status = ''
    @run.scheduled_at = ''
    @run.job = nil

    assert @run.invalid?
    assert_error @run, :status, :blank
    assert_error @run, :scheduled_at, :blank
    assert_error @run, :job, :blank
  end

  test 'included attributes' do
    @run.status = 'no_way'

    assert @run.invalid?
    assert_error @run, :status, :inclusion
  end

  test 'date attributes' do
    @run.scheduled_at = '13/13/13'
    @run.started_at = '13/13/13'
    @run.ended_at = '13/13/13'

    assert @run.invalid?
    assert_error @run, :scheduled_at, :invalid_datetime
    assert_error @run, :started_at, :invalid_datetime
    assert_error @run, :ended_at, :invalid_datetime
  end

  test 'ok' do
    assert !@run.ok?

    @run.status = 'ok'

    assert @run.ok?
  end

  test 'canceled' do
    assert !@run.canceled?

    @run.status = 'canceled'

    assert @run.canceled?
  end

  test 'should be canceled' do
    assert !@run.should_be_canceled?

    run = @run.dup

    run.save!
    run.mark_as_running

    assert @run.should_be_canceled?
  end

  test 'cancel run' do
    @run.cancel

    assert @run.reload.canceled?
  end

  test 'mark as running' do
    @run.mark_as_running

    assert_equal 'running', @run.reload.status
  end

  test 'finish' do
    @run.finish status: 'ok'

    assert_not_nil @run.reload.ended_at
    assert_equal 'ok', @run.status
  end

  test 'by status' do
    skip
  end

  test 'by scheduled at' do
    skip
  end

  test 'by script name' do
    skip
  end

  test 'schedule' do
    skip
  end

  test 'execute triggers' do
    skip
  end

  test 'scheduled' do
    skip
  end

  test 'overdue' do
    skip
  end

  test 'running' do
    skip
  end

  test 'cancel' do
    skip
  end
end
