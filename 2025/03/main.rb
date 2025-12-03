#!/usr/bin/env ruby

banks = ARGF.readlines.map(&:chomp)

def joltmax(bank, count)
  return "" if count < 1

  max = bank[..-count].chars.max
  max + joltmax(bank[bank.index(max)+1..], count - 1)
end


pp [
  banks.map { joltmax(it,  2) }.sum(&:to_i),
  banks.map { joltmax(it, 12) }.sum(&:to_i),
]
