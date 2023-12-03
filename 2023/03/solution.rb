#!/usr/bin/env ruby

lines = ARGF.readlines
grid = lines.map { |l| l.chomp.split("") }

ItemArea = Data.define(:value, :x_range, :y_range) do
  def overlap?(other)
    x_range.overlap?(other.x_range) && y_range.overlap?(other.y_range)
  end
end

symbols = grid.map.with_index { |row, y|
  row.map.with_index { |cell, x|
    ItemArea.new(cell, (x - 1)..(x + 1), (y - 1)..(y + 1)) if "*-$%+&/@=#".include? cell
  }.compact
}.flatten(1)

part_numbers = lines.map.with_index { |line, y|
  matches = line.to_enum(:scan, /\d+/).map { Regexp.last_match }
  matches.map { |m| ItemArea.new(m[0].to_i, Range.new(*m.offset(0), true), Range.new(y, y)) }
}.flatten(1)

valid_part_numbers = part_numbers.select do |part|
  symbols.any? { |symbol| symbol.overlap?(part) }
end

puts "Part 1: #{valid_part_numbers.sum(&:value)}"

gear_ratios = symbols
  .select { |symbol| symbol.value == "*" }
  .map { |symbol| part_numbers.select { |part| symbol.overlap?(part) } }
  .select { |parts| parts.length == 2 }
  .map { |parts| parts.map(&:value).inject(:*) }

puts "Part 2: #{gear_ratios.sum}"
