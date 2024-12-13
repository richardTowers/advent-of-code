#!/usr/bin/env ruby
# frozen_string_literal: true

require 'matrix'

PATTERN = /Button A: X\+(\d+), Y\+(\d+)
Button B: X\+(\d+), Y\+(\d+)
Prize: X=(\d+), Y=(\d+)/.freeze

input = ARGF.read

equations = input.scan(PATTERN).map do |matching_groups|
  ax, ay, bx, by, x, y = matching_groups.map(&:to_i)
  [Matrix[[ax, bx], [ay, by]], Matrix.column_vector([x, y])]
end

def sum_solutions(equations)
  equations.sum do |button_matrix, prize_vector|
    solution = button_matrix.inverse * prize_vector
    a = solution[0, 0]
    b = solution[1, 0]
    return 0 unless a.denominator == 1 && b.denominator == 1

    (3 * a + b).to_i
  end
end

part1 = sum_solutions(equations)

part2_equations = equations.map do |button_matrix, prize_vector|
  [button_matrix, prize_vector.collect { _1 + 10_000_000_000_000 }]
end
part2 = sum_solutions(part2_equations)

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
