# frozen_string_literal: true

require 'test_helper'

class ArrayControllerTest < ActionDispatch::IntegrationTest
  test 'should get input' do
    get array_input_url
    assert_response :success
  end

  test 'should get result' do
    get array_result_url
    assert_response :success
  end
end
