#!/usr/bin/env ruby

grid = ARGF.readlines
  .map(&:strip)
  .map{|l|l.split("")}

def distances(grid, expansion)
  galaxies = []
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      galaxies << [x, y] if cell == "#"
    end
  end

  emptyRowIndices = []
  grid
    .each_with_index do |row, y|
      if row.all?{|cell| cell == "."}
        emptyRowIndices << y 
      end
    end

  emptyColIndices = []
  grid.transpose
    .each_with_index do |col, y|
      emptyColIndices << y if col.all?{|cell| cell == "."}
    end

  galaxies.product(galaxies).map do |a, b|
    next 0 if a == b
    rowRange = Range.new(*[a[1], b[1]].sort, true)
    colRange = Range.new(*[a[0], b[0]].sort, true)
    emptyRowCount = emptyRowIndices.select{|i| rowRange.include? i}.count
    emptyColCount = emptyColIndices.select{|i| colRange.include? i}.count

    (rowRange.size - emptyRowCount) + (colRange.size - emptyColCount) + (expansion * emptyRowCount) + (expansion * emptyColCount)
  end
end

puts "Part 1: #{distances(grid, 2).sum / 2}"
puts "Part 2: #{distances(grid, 1_000_000).sum / 2}"