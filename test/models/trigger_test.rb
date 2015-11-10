require 'test_helper'

class TriggerTest < ActiveSupport::TestCase
  def setup
    @trigger = triggers :email
  end

  test 'blank attributes' do
    @trigger.callback = ''

    assert @trigger.invalid?
    assert_error @trigger, :callback, :blank
  end
end