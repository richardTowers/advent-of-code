#!/usr/bin/env ruby
# frozen_string_literal: true

# Definitions
Rule = Data.define(:first, :second) do
  def applies?(*args)
    args.include?(first) && args.include?(second)
  end

  def check(update)
    return true unless applies?(*update)

    update.index(first) < update.index(second)
  end

  def compare(left, right)
    case [left, right]
    when [first, second] then 1
    when [second, first] then -1
    else 0
    end
  end
end

def mid(arr)
  raise "length is not odd, array doesn't have a middle" unless arr.length.odd?

  arr[arr.length / 2]
end

# Parse input
input = ARGF.read

rules_input, updates_input = input.split("\n\n")

rules = rules_input.split("\n").map { _1.split('|').map(&:to_i) }.to_h { [Set[_1, _2], Rule.new(_1, _2)] }
updates = updates_input.split("\n").map { |update| update.split(',').map(&:to_i) }

# Part 1
correct, incorrect = updates.partition { |update| rules.values.all? { |rule| rule.check(update) } }
part1 = correct.sum { mid(_1) }

# Part 2
part2 = incorrect.sum { mid(_1.sort { |f, s| rules[Set[f, s]].compare(f, s) }) }

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
