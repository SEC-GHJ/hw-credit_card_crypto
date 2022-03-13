# frozen_string_literal: true

# Validates credit card number using Luhn Algorithm
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    check_sum = nums_a[0..-2].reverse.map.with_index.sum do |num, idx|
      if idx.odd?
        num
      else
        mul_two_and_divide(num).sum
      end
    end
    ((check_sum + nums_a[-1]) % 10).zero?
  end

  def mul_two_and_divide(num)
    (num * 2).to_s.chars.map(&:to_i)
  end
end
