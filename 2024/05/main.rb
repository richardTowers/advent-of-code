#!/usr/bin/env ruby
# frozen_string_literal: true

# Definitions
Rule = Data.define(:first, :second) do
  def check(update)
    return true unless update.include?(first) && update.include?(second)

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

rules = rules_input.split("\n").map { _1.split('|') }.map { Rule.new(_1, _2) }
updates = updates_input.split("\n").map { |update| update.split(',') }

# Part 1
correct, incorrect = updates.partition { |update| rules.all? { |rule| rule.check(update) } }
part1 = correct.sum { |update| mid(update).to_i }

# Part 2
part2 = incorrect.sum do |update|
  sorted = update.sort { |f, s| rules.map { |r| r.compare(f, s) }.reject(&:zero?).first }
  mid(sorted).to_i
end

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
