#!/usr/bin/env ruby

def e(grid)
  grid.map{|col| col.join("").scan(/[O.]+|#*/).map{|m| m.split("").sort}.flatten}
end

def s(grid)
  e(grid.transpose).transpose
end

def w(grid)
  e(grid.map(&:reverse)).map(&:reverse)
end

def n(grid)
  s(grid.reverse).reverse
end

def sum_weights(grid)
  grid.map.with_index{|row, i| row.count{|c| c=="O"} * (grid.length - i)}.sum
end

def find_in_cycle(value, target_index)
  values = []
  while true do
    value = yield value
    if values.include? value
      start = values.index(value)
      length = values.length - start
      return values[start + ((1_000_000_000 - start) % length) - 1]
    else
      values << value
    end
  end
end

grid = ARGF.readlines.map(&:strip).map{|line| line.split("")}
puts "Part 1: #{sum_weights(n(grid))}"
grid = find_in_cycle(grid, 1_000_000_000) {|x| e(s(w(n(x)))) }
puts "Part 2: #{sum_weights(grid)}"