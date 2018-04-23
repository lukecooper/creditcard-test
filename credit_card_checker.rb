require_relative 'credit_card_validator'

# Performs checks against a number of registered card validation types and formats the output
# to the required specification:
#  "TYPE: NUMBERS                (VALIDITY)"
class CreditCardChecker
  attr_reader :card_validators

  def initialize
    @card_validators = Array.new
    @card_validators << CreditCardValidator.new("AMEX", %w[33 37], [15])
    @card_validators << CreditCardValidator.new("Discover", %w[6011], [16])
    @card_validators << CreditCardValidator.new("MasterCard", %w[51 51 53 54 55], [16])
    @card_validators << CreditCardValidator.new("VISA", %w[4], [13, 16])
  end

  # performs the full check of the card number and formats the response
  def check_cc(cc_number)
    clean_number = clean_cc(cc_number)
    format_cc(clean_number, @card_validators.detect { |card_type| card_type.is_card_type?(clean_number) })
  end

  # strips all whitespace from the input string
  def clean_cc(cc_number)
    cc_number.gsub(/\s+/, "")
  end

  # formats the output of the card check depending on the given card_type
  def format_cc(cc_number, card_type)
    card_str = "%s: %s" % [card_type.nil? ? "Unknown" : card_type.type, cc_number]
    "%-28s (%s)" % [card_str, card_type.nil? || !card_type.is_valid?(cc_number) ? "invalid" : "valid"]
  end
end