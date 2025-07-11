# frozen_string_literal: true

class Calculator
  def add(input)
    return 0 if input.strip.empty?

    numbers_part = input
    delimiter_pattern = /,|\n/ # default delimiters

    if input.start_with?('//')
      header, numbers_part = input.split("\n", 2)

      delimiters = if header.include?('[')
                     # Multiple or multi-character delimiters like //[***][@@]
                     header.scan(/\[([^\]]+)\]/).flatten
                   else
                     # Single-character custom delimiter like //;
                     [header[2]]
                   end

      delimiter_pattern = Regexp.union(delimiters)
    end

    numbers = numbers_part.split(delimiter_pattern).map(&:to_i)

    negatives = numbers.select(&:negative?)
    raise "negative numbers not allowed: #{negatives.join(',')}" if negatives.any?

    numbers.sum
  end
end
