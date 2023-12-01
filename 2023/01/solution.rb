#!/usr/bin/env ruby

def solve(lines)
  values = lines.map do |line|
    first_digit = line.match(/\d/)[0]
    last_digit  = line.match(/(\d)\D*$/)[1]
    first_digit + last_digit
  end
  values.map{|v| v.to_i}.sum
end

raw_lines = ARGF.readlines()

part_1_result = solve(raw_lines)
puts "Part 1: #{part_1_result}"

replacements = {
  "one"   => "one1one",
  "two"   => "two2two",
  "three" => "three3three",
  "four"  => "four4four",
  "five"  => "five5five",
  "six"   => "six6six",
  "seven" => "seven7seven",
  "eight" => "eight8eight",
  "nine"  => "nine9nine",
}

new_lines = raw_lines.map do |line|
  new_line = line
  match = nil
  replacements.each do |word, replacement|
    new_line.gsub! word, replacement
  end
  new_line
end

part_2_result = solve(new_lines)
puts "Part 2: #{part_2_result}"

