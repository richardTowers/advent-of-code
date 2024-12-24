#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
input = ARGF.read
wires_input, operations_input = input.split("\n\n")
wires = wires_input.split("\n")
                   .to_h { /(\w\d\d): ([10])/.match(_1)[1..] }
                   .transform_values(&:to_i)
operations = operations_input.split("\n")
                             .map { /(\w+) (\w+) (\w+) -> (\w+)/.match(_1)[1..] }

op_queue = operations.dup
until op_queue.empty?
  op = op_queue.find { |l, _, r, _| wires.key?(l) && wires.key?(r) }
  op_queue.delete(op)
  left, operator, right, result = op
  wires[result] =
    case operator
    when 'AND' then wires.fetch(left) & wires.fetch(right)
    when 'OR' then wires.fetch(left) | wires.fetch(right)
    when 'XOR' then wires.fetch(left) ^ wires.fetch(right)
    end
end

# Part 1
part1 = wires.select { _1 =~ /z\d\d/ }.sort.reverse.map { _2 }.join('').to_i(2)

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
