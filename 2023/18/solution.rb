#!/usr/bin/env ruby

DIRECTIONS = {
  "U" => 0-1i,
  "R" => 1+0i,
  "D" => 0+1i,
  "L" => -1+0i,
}

Instruction = Data.define(:direction, :distance, :colour)
Edge = Data.define(:xrange, :yrange, :colour)

instructions = ARGF.readlines.map do |line|
  matches = line.match(/([ULDR]) (\d+) (\(#[0-9a-f]{6}\))/)
  raise "Unexpeted input #{line}" if matches.nil?
  direction, colour = matches.values_at(1, 3)
  distance = matches[2].to_i
  Instruction.new(DIRECTIONS[direction], distance, colour)
end

current_position = 0+0i
edges = instructions.map do |instruction|
  old_position = current_position
  current_position += instruction.direction * instruction.distance
  Edge.new(
    Range.new(*[old_position.real, current_position.real].sort),
    Range.new(*[old_position.imag, current_position.imag].sort),
    instruction.colour
  )
end
horizontal_edges, vertical_edges = edges.partition { |e| e.yrange.size == 1 }

rectangles = []
vertical_ranges = horizontal_edges.group_by { |e| e.yrange.min}.keys.sort.each_cons(2).map{|s| Range.new(*s)}.to_a
vertical_ranges.each { |vrange|
  crossings = vertical_edges.select{ |e| e.yrange.include?(vrange.min + 0.5)}.map(&:xrange).map(&:min).sort.each_slice(2).map{|s| Range.new(*s)}.to_a
  crossings.each{|c| rectangles << [c, vrange]}
}
pp rectangles