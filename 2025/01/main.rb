#!/usr/bin/env ruby

input = ARGF.readlines.map { it.sub(?L, ?-).sub(?R, ?+) }.map(&:to_i)

zeros = 0
dial = 50
positions = input.map do |n|
  new_dial = dial + n
  range = Range.new(*[dial + (n <=> 0), new_dial].sort)
  zeros += range.map { it % 100 }.count(&:zero?)
  dial = new_dial
end

puts "Part 1: #{positions.count { (it % 100).zero? }}"
puts "Part 2: #{zeros}"


