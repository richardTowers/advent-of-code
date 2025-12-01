#!/usr/bin/env ruby

input = ARGF.readlines
  .map { /(L|R)(\d+)/.match(it) }
  .map { |match| [match[1], match[2].to_i] }

dial = 50
positions = input.map do |dir, n|
  case dir
  in "L" then dial = (dial - n) % 100
  in "R" then dial = (dial + n) % 100
  end
  puts dial
  dial
end

pp positions.count { it.zero? }
