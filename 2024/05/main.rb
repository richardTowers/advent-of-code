#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
input = ARGF.read

page_ordering_rules_input, updates_input = input.split("\n\n")

def check_page_ordering_rule(first, second, update)
  if update.include?(first) && update.include?(second)
    update.index(first) < update.index(second)
  else
    true
  end
end

page_ordering_rules = page_ordering_rules_input
                        .split("\n")
                        .map { |rule| rule.split('|') }
                        .map { |first, second| ->(update) { check_page_ordering_rule(first, second, update) } }

updates = updates_input.split("\n").map { |update| update.split(',') }

correctly_ordered_updates = updates.select do |update|
  page_ordering_rules.all? { |rule| rule.call(update) }
end

puts "#{updates.length} total updates, of which #{correctly_ordered_updates.length} are correct"

# Part 1
part1 = correctly_ordered_updates.sum do |update|
  raise "no middle element" if update.length.even?

  update[update.length / 2].to_i
end

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
