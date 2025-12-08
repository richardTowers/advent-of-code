#!/usr/bin/env ruby

input = $<.map { it.split(",").map(&:to_i) }

connections = 0
input
  .combination(2)
  .sort_by { |l, r| l.zip(r).sum { it.reduce(:-)**2 } }
  .map(&:to_set)
  .reduce(input.map { [it].to_set }) do |circuits, pair|
    puts "Part 1: #{circuits.map(&:count).sort.reverse.take(3).reduce(:*)}" if connections == 1000
  
    intersecting, non_intersecting = circuits.partition { pair.intersect?(it) }
    if intersecting.count > 0
      connections += 1
      result = [intersecting.reduce(:|)] + non_intersecting
      break puts "Part 2: #{pair.map(&:first).reduce(:*)}" if result.count == 1
  
      result
    else
      non_intersecting
    end
  end

