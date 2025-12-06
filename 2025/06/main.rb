#!/usr/bin/env ruby

input = $<.to_a
split_h = input.map { it.strip.split(/ +/) }
part_1 = split_h.last
  .map(&:to_sym)
  .zip(split_h[...-1].map { it.map(&:to_i) }.transpose)
  .sum { _2.reduce(_1) }

instructions = input.map { it.chomp.split("") }.transpose.flat_map do |column|
  next [nil] if column.all? { it == " " }
  
  if %w[+ *].include?(column.last)
    [column.last.to_sym, column[...-1].join("").to_i]
  else
    [column.join("").to_i]
  end
end.slice_before(&:nil?).map(&:compact)

part_2 = instructions.sum { |instructions| instructions[1..].reduce(instructions.first) }

pp [
  part_1,
  part_2,
]

