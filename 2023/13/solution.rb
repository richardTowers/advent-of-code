#!/usr/bin/env ruby

grids = ARGF.read.split("\n\n")

def diff(left, right)
  left.flatten.zip(right.flatten).count{|left, right| left != right}
end

def reflect(rows, smudginess)
  (1...rows.length).select { |i|
    size = [i, rows.length - i].min
    diff(rows[...i].reverse[...size], rows[i..][...size]) == smudginess
  }.first || 0
end

def solve(grids, smudginess)
  reflections = grids.map do |grid|
    rows = grid.split("\n").map{|row| row.split("")}
    100 * reflect(rows, smudginess) + reflect(rows.transpose, smudginess)
  end
  reflections.sum
end

puts "Part 1: #{solve(grids, 0)}"
puts "Part 2: #{solve(grids, 1)}"