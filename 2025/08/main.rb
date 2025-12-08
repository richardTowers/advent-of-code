#!/usr/bin/env ruby

input = $<.map { it.split(",").map(&:to_i) }
distances = input
  .combination(2)
  .map { |l, r| [[l, r].to_set, l.zip(r).sum { (_1 - _2)**2 }] }
  .sort_by { |_, distance| distance }

forest = input.map { Set.new([it]) }

connections = 0
distances.reduce(forest) do |acc, (pair, d)|
  if connections == 1000
    puts "Part 1: #{acc.map(&:count).sort_by { -it }.take(3).reduce(:*)}"
  end

  intersecting, non_intersecting = acc.partition { pair.intersect?(it) }

  result = if intersecting.count > 0
             connections += 1
             [intersecting.reduce(:|)] + non_intersecting
           else
             non_intersecting
           end

  if result.count == 1
    puts "Part 2: #{pair.map(&:first).reduce(:*)}"
    break result
  end

  result
end

