#!/usr/bin/env ruby
# Usage: ruby main.rb < cardnumbers
require_relative 'credit_card_checker'

checker = CreditCardChecker.new
ARGF.each do |line|
  puts checker.check_cc(line)
end