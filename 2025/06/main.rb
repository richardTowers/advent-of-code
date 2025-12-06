#!/usr/bin/env ruby

input = $<.to_a
split_h = input.map { it.strip.split(/ +/) }
part_1 = split_h.last
  .map(&:to_sym)
  .zip(split_h[...-1].map { it.map(&:to_i) }.transpose)
  .sum { _2.reduce(_1) }

instructions = []
current_instruction = []

input.map { it.chomp.split("") }.transpose.each do |column|
  if column.all? { it == " " }
    instructions << current_instruction
    current_instruction = []
    next
  end
  
  current_instruction << column.last.to_sym if column.last != " "
  current_instruction << column[...-1].join("").to_i
end
instructions << current_instruction

part_2 = instructions.sum { |instructions| instructions[1..].reduce(instructions.first) }

pp [
  part_1,
  part_2,
]

