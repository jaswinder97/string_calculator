# frozen_string_literal: true

require 'test_helper'

class CalculatorTest < ActiveSupport::TestCase
  def setup
    @calculator = Calculator.new
  end

  test 'returns 0 for empty input' do
    assert_equal 0, @calculator.add('')
  end

  test 'sums comma and newline-separated numbers' do
    assert_equal 6, @calculator.add("1,2\n3")
  end

  test 'supports custom single-character delimiter' do
    assert_equal 3, @calculator.add("//;\n1;2")
  end

  test 'supports custom multi-character delimiter' do
    assert_equal 6, @calculator.add("//[***]\n1***2***3")
  end

  test 'supports multiple custom delimiters' do
    assert_equal 6, @calculator.add("//[*][%]\n1*2%3")
  end

  test 'supports multiple multi-character delimiters' do
    assert_equal 10, @calculator.add("//[***][@@]\n1***2@@3***4")
  end

  test 'raises error for single negative number' do
    error = assert_raises(RuntimeError) do
      @calculator.add('1,-2,3')
    end
    assert_match(/negative numbers not allowed: -2/, error.message)
  end

  test 'raises error listing all negative numbers' do
    error = assert_raises(RuntimeError) do
      @calculator.add('1,-2,-5,3,-7')
    end
    assert_equal 'negative numbers not allowed: -2,-5,-7', error.message
  end
end
