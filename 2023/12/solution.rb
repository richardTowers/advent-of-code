#!/usr/bin/env ruby

Row = Data.define(:springs, :groups)
input = ARGF.readlines.map(&:strip).map do |line|
  springs, groupStr = line.split(" ")
  groups = groupStr.scan(/\d+/).map(&:to_i)
  Row.new(springs, groups)
end

def permutations(row)
  if row.springs.include?("?")
    dotAttempt = Row.new(row.springs.sub("?", "."), row.groups)
    hashAttempt = Row.new(row.springs.sub("?", "#"), row.groups)
    permutations(dotAttempt) + permutations(hashAttempt)
  else
    groups = row.springs.scan(/#+/).map(&:length)
    row.groups == groups ? 1 : 0
  end
end

arrangementCounts = input.map.with_index{|row, i| puts i; permutations(row)}

puts "Part 1: #{arrangementCounts.sum}"