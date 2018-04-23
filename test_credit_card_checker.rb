require 'test/unit'
require_relative 'credit_card_checker'

class TestCreditCardChecker < Test::Unit::TestCase
  attr_reader :checker

  def setup
    @checker = CreditCardChecker.new
  end

  def teardown
    # Do nothing
  end

  def test_clean
    assert_equal(@checker.clean_cc("431 09   54"), "4310954", "CC number is cleaned")
    assert_equal(@checker.clean_cc("4315 9673 0987 2908 7989"), "43159673098729087989", "Big CC number is cleaned")
  end

  def test_unknown
    assert_equal(@checker.check_cc("654909345499686"), "Unknown: 654909345499686     (invalid)", "Invalid unknown number")
    assert_equal(@checker.check_cc("6549TURTLE99686"), "Unknown: 6549TURTLE99686     (invalid)", "Invalid unknown number")
  end

  def test_spec
    assert_equal(@checker.check_cc("4111111111111111"),    "VISA: 4111111111111111       (valid)")
    assert_equal(@checker.check_cc("4111111111111"),       "VISA: 4111111111111          (invalid)")
    assert_equal(@checker.check_cc("4012888888881881"),    "VISA: 4012888888881881       (valid)")
    assert_equal(@checker.check_cc("378282246310005"),     "AMEX: 378282246310005        (valid)")
    assert_equal(@checker.check_cc("6011111111111117"),    "Discover: 6011111111111117   (valid)")
    assert_equal(@checker.check_cc("5105105105105100"),    "MasterCard: 5105105105105100 (valid)")
    assert_equal(@checker.check_cc("5105 1051 0510 5106"), "MasterCard: 5105105105105106 (invalid)")
    assert_equal(@checker.check_cc("9111111111111111"),    "Unknown: 9111111111111111    (invalid)")
  end
end