#!/usr/bin/env ruby

def steps(list)
  diffs = list.each_cons(2).map{|x, y| y - x}
  return [list.last] if diffs.all?(&:zero?)
  [list.last, *steps(diffs)]
end

input = ARGF.readlines.map{|line| line.scan(/-?\d+/).map(&:to_i)}

puts "Part 1: #{input.map{|line| steps(line).sum}.sum}"
puts "Part 2: #{input.map{|line| steps(line.reverse).sum}.sum}"
