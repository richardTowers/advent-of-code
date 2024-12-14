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

part1_positions = robots.map { position_after(_1, 100) }.tally
l, r = part1_positions
       .reject { |pos, _count| pos.real == WIDTH / 2 }
       .reject { |pos, _count| pos.imag == HEIGHT / 2 }
       .partition { |pos, _count| pos.real < WIDTH / 2 }

tl, bl = l.partition { |pos, _count| pos.imag < HEIGHT / 2 }
tr, br = r.partition { |pos, _count| pos.imag < HEIGHT / 2 }

pp tl.sum { _2 }
pp bl.sum { _2 }
pp tr.sum { _2 }
pp br.sum { _2 }

# Part 1
part1 = [tl, bl, tr, br].map { |quad| quad.sum { _2 } }.inject(&:*)

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
