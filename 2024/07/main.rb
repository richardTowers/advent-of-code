#!/usr/bin/env ruby
# frozen_string_literal: true

# Definitions
Equation = Data.define(:test_value, :numbers) do
  def valid?(*operators)
    possible_values(*operators).include?(test_value)
  end

  def possible_values(*operators)
    first, *rest = numbers
    rest.reduce([first]) do |possibilities, num|
      possibilities.flat_map do |poss|
        operators.map { _1.call(poss, num) }.reject { _1 > test_value }
      end
    end
  end
end

# Parse input
lines = ARGF.readlines
equations = lines.map do |line|
  l, r = line.split(':')
  Equation.new(l.to_i, r.split.map(&:to_i))
end

# Part 1
add = ->(a, b) { a + b }
mul = ->(a, b) { a * b }
part1 = equations
        .select { _1.valid?(add, mul) }
        .sum(&:test_value)

# Part 2
cat = ->(a, b) { "#{a}#{b}".to_i }
part2 = equations
        .select { _1.valid?(add, mul, cat) }
        .sum(&:test_value)

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
