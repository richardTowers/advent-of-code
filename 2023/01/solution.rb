#!/usr/bin/env ruby

def lookup(haystack, needle)
  (haystack.index(needle) % 9 + 1).to_s
end

def solve(lines, patterns)
  forward_pattern = patterns.join("|")
  reverse_pattern = patterns.map(&:reverse).join("|")
  values = lines.map do |line|
    first_digit = lookup(patterns, line.match(forward_pattern)[0])
    last_digit  = lookup(patterns, line.reverse.match(reverse_pattern)[0].reverse)
    first_digit + last_digit
  end
  values.map{|v| v.to_i}.sum
end

lines = ARGF.readlines()
puts solve(lines, ('1'..'9').to_a)
puts solve(lines, ('1'..'9').to_a + %w{one two three four five six seven eight nine})

