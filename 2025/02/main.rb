#!/usr/bin/env ruby

all_digits = ARGF
  .read
  .split(",")
  .map { it.split("-").map(&:to_i) }
  .flat_map { [*_1.._2] }

part_1 = all_digits
  .select do |n|
    digits = n.to_s.split("")
    digits == digits.rotate(digits.length / 2)
  end.sum

part_2 = all_digits
  .select do |n|
    digits = n.to_s.split("")
    (1..digits.length / 2).map { digits.rotate(it) }.include?(digits)
  end.sum

pp [
  part_1,
  part_2,
]
  

