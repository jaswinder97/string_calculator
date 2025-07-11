require "test_helper"

class CalculatorTest < ActiveSupport::TestCase
  def setup
    @calculator = Calculator.new
  end

  test "returns 0 for empty input" do
    assert_equal 0, @calculator.add("")
  end

  test "sums comma and newline-separated numbers" do
    assert_equal 6, @calculator.add("1,2\n3")
  end

  test "raises error for negative numbers" do
    error = assert_raises(RuntimeError) do
      @calculator.add("1,-2,3")
    end
    assert_match /negative numbers not allowed: -2/, error.message
  end
end
