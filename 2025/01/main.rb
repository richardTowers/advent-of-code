#!/usr/bin/env ruby

input = ARGF.readlines
  .map { /(L|R)(\d+)/.match(it) }
  .map { |match| [match[1], match[2].to_i] }

dial = 50
positions = input.map do |dir, n|
  case dir
  in "L" then dial = (dial - n)
  in "R" then dial = (dial + n)
  end
end

puts "Part 1: #{positions.count { (it % 100).zero? }}"


