#!/usr/bin/env ruby

all_digits = ARGF
  .read
  .split(",")
  .flat_map { Range.new(*it.chomp.split("-").map(&:to_i)).to_a }

part_1 = all_digits
  .select do |n|
    digits = n.to_s.split("")
    digits == digits.rotate(digits.length / 2)
  end.sum

part_2 = all_digits
  .select do |n|
    digits = n.to_s.split("")
    rotations = (1..digits.length / 2).map { digits.rotate(it) }
    rotations.include?(digits)
  end.sum

pp [
  part_1,
  part_2,
]
  

