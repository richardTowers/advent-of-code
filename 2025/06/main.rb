#!/usr/bin/env ruby

input = $<.map { it.strip.split(/ +/) }
part_1 = input.last
  .map(&:to_sym)
  .zip(input[...-1].map { it.map(&:to_i) }.transpose)
  .sum { _2.reduce(_1) }

pp [
  part_1,
  :TODO,
]

