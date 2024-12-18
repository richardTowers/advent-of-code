#!/usr/bin/env ruby
# frozen_string_literal: true

WIDTH = 101
HEIGHT = 103

# Parse input
lines = ARGF.readlines
robots = lines.map do |line|
  x, y, vx, vy = /p=(\d+),(\d+) v=(-?\d+),(-?\d+)/.match(line)[1..].map(&:to_i)
  [x + 1i * y, vx + 1i * vy]
end

def position_after(robot, seconds)
  p, v = robot
  new_p = p + seconds * v
  Complex.rect(new_p.real % WIDTH, new_p.imag % HEIGHT)
end

positions = robots.map { position_after(_1, 100) }.tally
l, r = positions
       .reject { |pos, _count| pos.real == WIDTH / 2 }
       .reject { |pos, _count| pos.imag == HEIGHT / 2 }
       .partition { |pos, _count| pos.real < WIDTH / 2 }

tl, bl = l.partition { |pos, _count| pos.imag < HEIGHT / 2 }
tr, br = r.partition { |pos, _count| pos.imag < HEIGHT / 2 }

# Part 1
part1 = [tl, bl, tr, br].map { |quad| quad.sum { _2 } }.inject(&:*)

part2 = (0..).find do |i|
  positions = robots.map { position_after(_1, i) }.tally
  overlap_count = positions.count { _2 > 1 }
  overlap_count.zero?
end

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
