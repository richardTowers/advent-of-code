#!/usr/bin/env ruby
require 'matrix'

Hail = Data.define(:position, :velocity)

def find_intersection(a, b)
  m = Matrix[a.velocity.rectangular, (-1 * b.velocity).rectangular].transpose
  v = Matrix.column_vector((b.position - a.position).rectangular)

  return nil if m.singular?

  times = m.inverse * v
  return nil unless times.all?(&:positive?)

  a.position + a.velocity * times.first
end

hails = ARGF.readlines.map(&:strip).map do |line|
  pos_str, vel_str = line.split("@")
  Hail.new(
    Complex(*pos_str.scan(/-?\d+/).map(&:to_i).values_at(0, 1)),
    Complex(*vel_str.scan(/-?\d+/).map(&:to_i).values_at(0, 1)),
  )
end

range = (200000000000000..400000000000000)
intersections = hails.combination(2)
  .map { |a, b| find_intersection(a, b) }
  .compact
  .select { |i| range.include?(i.real) && range.include?(i.imag) }

puts "Part 1: #{intersections.count}"