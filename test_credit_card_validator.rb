require 'test/unit'
require_relative 'credit_card_validator'

class TestCreditCardValidator < Test::Unit::TestCase
  attr_reader :amex
  attr_reader :visa

  def setup
    @amex = CreditCardValidator.new("AMEX", %w[33 37], [15])
    @visa = CreditCardValidator.new("Visa", %w[4], [13, 16])
  end

  def teardown
    # Do nothing
  end

  def test_card_type
    assert(@amex.is_card_type?("33"), "AMEX card starts with 33")
    assert(@amex.is_card_type?("37"), "AMEX card starts with 37")
    assert(!@amex.is_card_type?("34"), "AMEX card does not start with 34")
  end

  def test_length_valid
    assert(@visa.length_valid?("4314872909871"), "VISA card length is valid (13)")
    assert(@visa.length_valid?("4314872909871234"), "VISA card length is valid (16)")
    assert(!@visa.length_valid?("431487290987123"), "VISA card length is not valid")
  end

  def test_numbers
    assert(@visa.numbers?("48576920"), "CC number is all numbers")
    assert(!@visa.numbers?("485769F0"), "CC number is not all numbers")
    assert(!@visa.numbers?("4  85769F0"), "CC number is not all numbers")
  end

  def test_sum
    assert_equal(@visa.sum("12345"), 15, "12345 add up to 15")
    assert_not_equal(@visa.sum("123456"), 15, "123456 does not add up to 15")
  end

  def test_luhn_double
    assert_equal(@visa.luhn_double("4408041234567893"), "8408042264106148183", "Luhn double test case")
    assert_equal(@visa.luhn_double("1212"), "2222", "Luhn double even length")
    assert_equal(@visa.luhn_double("12121"), "14141", "Luhn double odd length")
  end

  def test_luhn_valid
    assert(@visa.luhn_valid?("4408041234567893"), "Luhn valid success case")
    assert(!@visa.luhn_valid?("4417123456789112"), "Luhn valid failure case")
  end

  def test_is_valid
    assert(@visa.is_valid?("4111111111111111"), "VISA card valid")
    assert(!@visa.is_valid?("4111111111111"), "VISA card invalid")
    assert(@amex.is_valid?("378282246310005"), "Amex card valid")
  end
end