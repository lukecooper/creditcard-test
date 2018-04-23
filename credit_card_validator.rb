
# Enforces validation rules for a credit card type
class CreditCardValidator
  attr_reader :type
  attr_reader :prefixes
  attr_reader :lengths

  def initialize(type, prefixes, lengths)
    @type = type
    @prefixes = prefixes
    @lengths = lengths
  end

  # checks if the given string of number matches one or more of the registered prefixes
  def is_card_type?(cc_numbers)
    @prefixes.any? { |prefix| cc_numbers.start_with?(prefix) }
  end

  # performs all tests (card type, length and luhn check) to see if the card is valid for this type
  def is_valid?(cc_numbers)
    is_card_type?(cc_numbers) && length_valid?(cc_numbers) && luhn_valid?(cc_numbers)
  end

  # check if the given string of numbers matches one of the registered lengths
  def length_valid?(cc_numbers)
    @lengths.any? { |length| cc_numbers.length == length }
  end

  # performs the luhn algorithm for testing if a card number is valid
  def luhn_valid?(cc_numbers)
    numbers?(cc_numbers) && sum(luhn_double(cc_numbers)) % 10 == 0
  end

  # checks if all characters of the given string are numbers
  # (inefficient check but copes with large numbers)
  def numbers?(cc_numbers)
    cc_numbers.chars.all? { |cc_num| cc_num == cc_num.to_i.to_s }
  end

  # returns a copy of the string with every second number doubled, starting from
  # the second last number going back to the beginning
  def luhn_double(cc_numbers)
    double_idx = cc_numbers.length.even? ? 0 : 1
    cc_numbers.chars.map.with_index { |cc_number, i|
      if i % 2 == double_idx
        (Integer(cc_number) * 2).to_s
      else
        cc_number
      end
    }.join
  end

  # returns the sum of all digits in a string of numbers
  def sum(cc_numbers)
    cc_numbers.chars.map { |c| Integer(c) }.inject(0, :+)
  end
end