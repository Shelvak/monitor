require 'test_helper'

class ParameterTest < ActiveSupport::TestCase
  def setup
    @parameter = parameters :ls_dir
  end

  test 'blank attributes' do
    @parameter.name = ''
    @parameter.value = ''

    assert @parameter.invalid?
    assert_error @parameter, :name, :blank
    assert_error @parameter, :value, :blank
  end

  test 'attributes length' do
    @parameter.name = 'abcde' * 52
    @parameter.value = 'abcde' * 52

    assert @parameter.invalid?
    assert_error @parameter, :name, :too_long, count: 255
    assert_error @parameter, :value, :too_long, count: 255
  end

  test 'attributes format' do
    @parameter.name = 'with ] invalid char =)'
    @parameter.value = 'with ] invalid char =)'

    assert @parameter.invalid?
    assert_error @parameter, :name, :invalid
    assert_error @parameter, :value, :invalid
  end
end