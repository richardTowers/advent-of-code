#!/usr/bin/env ruby
require 'strscan'

MapRange = Data.define(:destination_range_start, :source_range_start, :length) do
  def lookup(value)
    distance_from_start = value - source_range_start
    if distance_from_start >= 0 && distance_from_start < length
      destination_range_start + distance_from_start
    else
      nil
    end
  end
end

Map = Data.define(:from, :to, :ranges) do
  def lookup(value)
    ranges.map{|r| r.lookup(value)}.compact.first || value
  end
end

input = ARGF.read

groups = input.split(/^$/).map(&:strip)
seeds = groups[0].scan(/\d+/).map(&:to_i)
maps = groups[1..].map do |g|
  lines = g.split("\n")
  from, to = lines[0].match(/(\w+)-to-(\w+) map:/).values_at(1, 2)
  ranges = lines[1..].map do |l|
    MapRange.new(*l.scan(/\d+/).map(&:to_i))
  end
  Map.new(from, to, ranges)
end

location_numbers = seeds.map{|s| maps.reduce(s){|acc, m| m.lookup(acc)} }

puts "Part 1: #{location_numbers.min}"

min = Float::INFINITY
seeds.each_slice(2) do |start, length|
  (start...start+length).each do |s|
    location_number = maps.reduce(s){|acc, m| m.lookup(acc)}
    min = location_number if location_number < min
  end
end

puts "Part 2: #{min}"