#!/usr/bin/env ruby

Row = Data.define(:springs, :groups)
input = ARGF.readlines.map(&:strip).map do |line|
  springs, groupStr = line.split(" ")
  groups = groupStr.scan(/\d+/).map(&:to_i)
  Row.new(springs, groups)
end

@cache = {}
def solve(row, spring_index = 0, group_index = 0, previous_spring = ".")
  cache_key = [row, spring_index, group_index, previous_spring]
  return @cache[cache_key] if @cache.key?(cache_key)

  result = 0

  spring = row.springs[spring_index]
  group_length = row.groups[group_index]
  
  if group_length.nil?
    if row.springs[spring_index..] =~ /^[?.]*$/
      return 1 
    else
      return 0
    end
  elsif spring.nil?
    return 0
  end

  group_candidate = row.springs[spring_index..][...group_length]
  following_spring = row.springs[spring_index + group_length]

  result += solve(row, (spring_index + 1), group_index, ".") if spring =~ /[.?]/

  if group_candidate =~ /^[?#]+$/ && following_spring != "#" && previous_spring != "#"
    result += solve(row, spring_index + group_length, group_index + 1, "#")
  end
  
  @cache[cache_key] = result
  result
end

arrangementCounts = input.map{|row| solve(row) }
puts "Part 1: #{arrangementCounts.sum}"
foldedCounts = input.map{|row| solve(Row.new((row.springs + "?") * 4 + row.springs, row.groups * 5)) }
puts "Part 2: #{foldedCounts.sum}"
