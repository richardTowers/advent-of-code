#!/usr/bin/env ruby

lines = ARGF.readlines
grid = lines.map { |l| l.chomp.split("") }
height = grid.length
width = grid.first.length

adjacents = grid.map { |row| row.map { |_cell| false } }
rotations = [-1, 0, 1].product([-1, 0, 1])
grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    next unless %w[* - $ % + & / @ = #].include? cell

    rotations.each do |dx, dy|
      ax = (x + dx).clamp(0..width)
      ay = (y + dy).clamp(0..height)
      adjacents[ay][ax] = true
    end
  end
end

part_numbers = lines.zip(adjacents).flat_map do |line, adjuncts|
  matches = line.to_enum(:scan, /\d+/).map { Regexp.last_match }
  matches.select { |m| adjuncts[Range.new(*m.offset(0), true)].any? }.map { |m| m[0].to_i }
end

puts "Part 1: #{part_numbers.sum}"
