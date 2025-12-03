#!/usr/bin/env ruby

banks = ARGF.readlines.map(&:chomp).map { it.split("") }

def largest_joltage(bank, battery_count)
  return "" if battery_count < 1
  max = bank[..-battery_count].max
  index = bank.index(max)
  max + largest_joltage(bank[index+1..], battery_count - 1)
end


pp [
  banks.map { largest_joltage(it,  2) }.sum(&:to_i),
  banks.map { largest_joltage(it, 12) }.sum(&:to_i),
]
