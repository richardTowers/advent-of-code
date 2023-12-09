#!/usr/bin/env ruby

def steps(list, &block)
  diffs = list.each_cons(2).map{|x, y| y - x}
  return [] if diffs.all?(&:zero?)
  [block.call(diffs), *steps(diffs, &block)]
end

def solve(list)
  list.last + steps(list, &:last).reduce(0){|acc, s| s + acc}
end

input = ARGF.readlines.map{|line| line.scan(/-?\d+/).map(&:to_i)}

puts "Part 1: #{input.map{|line| solve(line)}.sum}"
puts "Part 2: #{input.map{|line| solve(line.reverse)}.sum}"
