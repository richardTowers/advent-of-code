#!/usr/bin/env ruby

def solve_quadratic(a, b, c)
  [1, -1].map { |plusOrMinus|
    (-b + plusOrMinus * Math.sqrt(b**2 - 4 * a * c)) / 2 * a
  }.sort
end

lines = ARGF.readlines
times = lines[0].scan(/\d+/).map(&:to_i)
distances = lines[1].scan(/\d+/).map(&:to_i)

def ways_to_win(time, distance)
  solutions = solve_quadratic(-1, time, -distance)
  result = (solutions.first.ceil...solutions.last.ceil).size
  result -= 1 if solutions.last == solutions.last.ceil
  result
end

allWaysToWin = times.zip(distances).map { |time, distance| ways_to_win(time, distance) }

puts "Part 1: #{allWaysToWin.inject(:*)}"

bigTime = lines[0].scan(/\d+/).inject(:+).to_i
bigDistance = lines[1].scan(/\d+/).inject(:+).to_i

puts "Part 2: #{ways_to_win(bigTime, bigDistance)}"
