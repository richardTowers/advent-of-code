#!/usr/bin/env ruby
# frozen_string_literal: true

# Data from the puzzle
numeric = [
  %w[7 8 9],
  %w[4 5 6],
  %w[1 2 3],
  %w[# 0 A],
]
directional = [
  %w[# ^ A],
  %w[< v >],
]
directions = {
  0 + 1i => 'v',
  0 - 1i => '^',
  1 + 0i => '>',
  -1 + 0i => '<',
}

def build_grid(arr)
  arr.flat_map.with_index do |row, ri|
    row.map.with_index { |cell, ci| [ci + 1i * ri, cell] }.reject { _2 == '#' }
  end.to_h
end

def find_paths(grid, directions)
  grid.keys.product(grid.keys).to_h do |from, to|
    vector = to - from
    reals = (vector.real.positive? ? [1 + 0i] : [-1 + 0i]) * vector.real.abs
    imags = (vector.imag.positive? ? [0 + 1i] : [0 - 1i]) * vector.imag.abs
    paths = (reals + imags).permutation.select do |moves|
      f = from
      moves.map { |d| f += d }.all? { grid.key?(_1) }
    end.uniq
    [[grid[from], grid[to]], paths.map { |path| path.map { directions[_1] } }]
  end
end

num_grid = build_grid(numeric)
num_paths = find_paths(num_grid, directions)
# pp num_paths.map { |ft, paths| [*ft, paths.map { _1.join('') }] }

dir_grid = build_grid(directional)

dir_paths = find_paths(dir_grid, directions)
grids = [num_paths, dir_paths, dir_paths]
# pp dir_paths.map { |ft, paths| [*ft, paths.map { _1.join('') }] }

def enter(row, grids, depth = 0)
  (['A'] + row).each_cons(2).map do |pair|
    if depth < grids.length
      ng = grids[depth][pair].map { _1 + ['A'] }
      ng.flat_map { { parent: pair, self: _1, depth:, paths: enter(_1, grids, depth + 1) } }
    else
      row
    end
  end
end

# def enter_directions(directions, dir_paths)
#   (['A'] + directions).each_cons(2).map do |pair|
#     dir_paths[pair].map { _1 + ['A'] }
#   end
# end
#
# def enter_row(row, num_paths, dir_paths)
#   (['A'] + row).each_cons(2).map do |nb1, nb2|
#     nps = num_paths[[nb1, nb2]].map { _1 + ['A'] }
#     pp ['nps', nps]
#     dp1s = nps.flat_map { |np| enter_directions(np, dir_paths) }
#     pp ['dp1s', dp1s]
#     dp2s = dp1s.flat_map { |dp1| dp1.flat_map { |dp| enter_directions(dp, dir_paths) } }
#     pp ['dp2s', dp2s]
#     dp2s.min_by(&:length)
#   end
# end

pp enter(%w[0 2 9 A], [num_paths, dir_paths, dir_paths])

# Parse input
lines = ARGF.readlines
rows = lines.map { _1.chomp.split('') }


# Part 1
part1 = nil

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
