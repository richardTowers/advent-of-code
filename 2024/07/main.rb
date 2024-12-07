#!/usr/bin/env ruby
# frozen_string_literal: true

# Definitions
Equation = Data.define(:test_value, :numbers) do
  def valid?(operands)
    possible_values(operands).include?(test_value)
  end

  def possible_values(operands)
    numbers.drop(1).reduce([numbers.first]) do |acc, n|
      acc.flat_map { operands.call(_1, n) }.select { _1 <= test_value }
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
part1 = equations
        .select { _1.valid?(->(l, r) { [l + r, l * r] }) }
        .sum(&:test_value)

# Part 2
part2 = equations
        .select { _1.valid?(->(l, r) { [l + r, l * r, "#{l}#{r}".to_i] }) }
        .sum(&:test_value)

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
