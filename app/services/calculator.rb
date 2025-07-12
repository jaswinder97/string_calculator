# frozen_string_literal: true

# Calculator service to parse and sum numbers from a string.
# Supports:
# - Comma and newline delimiters by default
# - Custom delimiters (single, multi-character, or multiple)
# - Exception on negative numbers

class Calculator
  # Adds all numbers in a given input string.
  #
  # @param input [String] the raw input string (e.g., "1,2", "//[***]\n1***2***3")
  # @return [Integer] sum of numbers
  # @raise [RuntimeError] if input contains negative numbers
  def add(input)
    return 0 if input.strip.empty?

    delimiter_pattern, numbers_part = parse_delimiters(input)
    numbers = extract_numbers(numbers_part, delimiter_pattern)

    raise_on_negatives!(numbers)

    numbers.sum
  end

  private

  # Parses custom or default delimiters and returns regex + number string
  def parse_delimiters(input)
    if input.start_with?('//')
      header, numbers_part = input.split("\n", 2)

      delimiters =
        if header.include?('[')
          header.scan(/\[([^\]]+)\]/).flatten
        else
          [header[2]]
        end

      [Regexp.union(delimiters), numbers_part]
    else
      [Regexp.new(",|\n"), input]
    end
  end

  # Splits number string using the delimiter pattern and returns array of integers
  def extract_numbers(numbers_part, delimiter_pattern)
    numbers_part.split(delimiter_pattern)
                .map(&:to_i)
                .reject { |n| n > 1000 }
  end

  # Raises exception if any negative numbers are found
  def raise_on_negatives!(numbers)
    negatives = numbers.select(&:negative?)
    return if negatives.empty?

    raise "negative numbers not allowed: #{negatives.join(',')}"
  end
end
