#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
input = ARGF.read

page_ordering_rules_input, updates_input = input.split("\n\n")

class PageOrderingRule
  attr_reader :first, :second

  def initialize(first, second)
    @first = first
    @second = second
  end

  def check_page_ordering_rule(update)
    if update.include?(first) && update.include?(second)
      update.index(first) < update.index(second)
    else
      true
    end
  end

  def compare(f, s)
    if f == first && s == second
      1
    elsif f == second && s == first
      -1
    else
      0
    end
  end
end

page_ordering_rules = page_ordering_rules_input
                        .split("\n")
                        .map { |rule| rule.split('|') }
                        .map { |first, second| PageOrderingRule.new(first, second) }

updates = updates_input.split("\n").map { |update| update.split(',') }

correctly_ordered_updates = updates.select do |update|
  page_ordering_rules.all? { |rule| rule.check_page_ordering_rule(update) }
end

puts "#{updates.length} total updates, of which #{correctly_ordered_updates.length} are correct"

# Part 1
part1 = correctly_ordered_updates.sum do |update|
  raise "no middle element" if update.length.even?

  update[update.length / 2].to_i
end

incorrectly_ordered_updates = updates.reject do |update|
  page_ordering_rules.all? { |rule| rule.check_page_ordering_rule(update) }
end

incorrectly_ordered_updates.map do |update|
  update.sort! { |f, s| page_ordering_rules.map { |r| r.compare(f, s) }.reject(&:zero?).first }
end

# Part 2
part2 = incorrectly_ordered_updates.sum do |update|
  raise "no middle element" if update.length.even?

  update[update.length / 2].to_i
end

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
