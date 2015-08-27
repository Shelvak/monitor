require 'test_helper'

class JobTest < ActiveSupport::TestCase
  def setup
    @job = jobs :cd_root_on_atahualpa
  end

  test 'blank attributes' do
    @job.server = nil
    @job.script = nil

    assert @job.invalid?
    assert_error @job, :server, :blank
    assert_error @job, :script, :blank
  end
end
