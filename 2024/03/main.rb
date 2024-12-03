#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
input = ARGF.read

Token = Data.define(:op, :l, :r)
tokens = input
         .scan(/(\w[\w']+)\((?:(\d+),(\d+))?\)/)
         .map { |op, l, r| Token.new(op, l.to_i, r.to_i) }

# Part 1
part1 = tokens
        .select { |token| token.op == 'mul' }
        .sum { |token| token.l * token.r }

# Part 2
active = true
part2 = tokens.sum do |token|
  case token
  in { op: 'do' }
    active = true
    0
  in { op: "don't" }
    active = false
    0
  in { op: 'mul', l:, r: } if active
    l * r
  else
    0
  end
end

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
