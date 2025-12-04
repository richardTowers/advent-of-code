#!/usr/bin/env ruby

rolls = $<.flat_map.with_index do |row, y|
  row.chomp.chars.map.with_index { |cell, x| x - y*1i if cell == "@" }.compact
end.to_set

DIRECTIONS = [-1+1i, 1i, 1+1i, -1, 1, -1-1i, -1i, 1-1i]

part_1 = rolls.count { |roll| (rolls & DIRECTIONS.to_set { roll + it }).count < 4 }

def remove_rolls(rolls)
  rolls.reject { |roll| (rolls & DIRECTIONS.to_set { roll + it }).count < 4 }.to_set
end


new_rolls = rolls
while new_rolls != (new_rolls = remove_rolls(new_rolls)); end

pp [
  part_1,
  rolls.count - new_rolls.count,
]



