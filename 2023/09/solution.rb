#!/usr/bin/env ruby

def lastSteps(enum)
  diffs = enum.each_cons(2).map{|x, y| y - x}
  return [] if diffs.all?(&:zero?)
  [diffs.last, *lastSteps(diffs)]
end

def firstSteps(enum)
  diffs = enum.each_cons(2).map{|x, y| y - x}
  return [] if diffs.all?(&:zero?)
  [*firstSteps(diffs), diffs.first]
end

input = ARGF.readlines.map{|line| line.scan(/-?\d+/).map(&:to_i)}

part1 = input.map{|list| list.last  +  lastSteps(list).reduce(0){|acc, s| s + acc}}.sum
part2 = input.map{|list| list.first - firstSteps(list).reduce(0){|acc, s| s - acc}}.sum

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"