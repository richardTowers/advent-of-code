#!/usr/bin/env ruby

def tilt_east(grid)
  grid.map{|col| col.join("").scan(/[O.]+|#*/).map{|m| m.split("").sort}.flatten}
end

def tilt_south(grid)
  tilt_east(grid.transpose).transpose
end

def tilt_west(grid)
  tilt_east(grid.transpose.reverse.transpose).transpose.reverse.transpose
end

def tilt_north(grid)
  tilt_east(grid.reverse.transpose).transpose.reverse
end

def sum_weights(grid)
  grid.map.with_index{|row, i| row.count{|c| c=="O"} * (grid.length - i)}.sum
end

grid = ARGF.readlines.map(&:strip).map{|line| line.split("")}
ng = tilt_north(grid)
puts "Part 1: #{sum_weights(tilt_north(grid))}"

grids = []
while true do
  grid = tilt_north(grid)
  grid = tilt_west(grid)
  grid = tilt_south(grid)
  grid = tilt_east(grid)

  if grids.include? grid
    cycleStartPos = grids.index(grid)
    cycleLength = grids.length - cycleStartPos
    part2 = sum_weights(grids[cycleStartPos + ((1_000_000_000 - cycleStartPos) % cycleLength) - 1])
    puts "Part 2: #{part2}"
    break
  else
    grids << grid
  end
end
