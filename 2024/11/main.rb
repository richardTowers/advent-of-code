#!/usr/bin/env ruby
# frozen_string_literal: true

# Definitions
def blink_stone(stone)
  return [1] if stone.zero?

  log = Math.log10(stone + 1).ceil
  if log.even?
    magnitude = 10**(log / 2)
    first_digits = stone / magnitude
    last_digits = stone - first_digits * magnitude
    return [first_digits, last_digits]
  end

  [stone * 2024]
end

def blink(stone_counts)
  new_stone_counts = stone_counts.flat_map do |stone_count|
    stone, count = stone_count
    blink_stone(stone).map { |new_stone| [new_stone, count] }
  end

  new_stone_counts.group_by(&:first).transform_values { |pairs| pairs.sum { _2 } }
end

# Parse input
input = ARGF.read.chomp.split(' ').map(&:to_i)

result = input.tally
25.times { result = blink(result) }

part1 = result.values.sum
puts "Part 1: #{part1}"

50.times { result = blink(result) }

part2 = result.values.sum
puts "Part 2: #{part2}"
