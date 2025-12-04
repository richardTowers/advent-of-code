#!/usr/bin/env ruby

DIRECTIONS = [
  -1+1i, 1i , 1+1i,
  -1   ,      1   ,
  -1-1i, -1i, 1-1i,
]

def remove_rolls(rolls)
  rolls.reject { |roll| (rolls & DIRECTIONS.to_set { roll + it }).count < 4 }.to_set
end

def fixed_point(x, &block)
  block.call(x).then { it == x ? it : fixed_point(it, &block) }
end

rolls = $<.flat_map.with_index do |row, y|
  row.chars.map.with_index { |cell, x| x - y*1i if cell == "@" }.compact
end.to_set

pp [
  rolls.count - remove_rolls(rolls).count,
  rolls.count - fixed_point(rolls, &method(:remove_rolls)).count,
]

