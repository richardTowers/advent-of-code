#!/usr/bin/env ruby

CARDINALS = {
  north: [0, -1],
  east: [1, 0],
  south: [0, 1],
  west: [-1, 0],
}

INSTRUCTIONS = {
  "L" => { south: :east, west: :north },
  "J" => { east: :north, south: :west },
  "7" => { north: :west, east: :south },
  "F" => { north: :east, west: :south },
  "|" => { north: :north, south: :south },
  "-" => { east: :east, west: :west },
  "S" => {}
}

Mover = Data.define(:cell, :direction)
Cell = Data.define(:value, :coords) do
  def offset(o)
    coords.zip(o).map { |c, o| c + o }
  end
end

Loop = Data.define(:grid) do
  include Enumerable

  def initialize(args)
    args[:grid].each_with_index do |row, y|
      row.each_with_index do |cell, x|
        @start = [x, y] if cell == "S"
      end
    end
    @direction = [0, 0]
    super(args)
  end

  def lookup(coords)
    x, y = coords
    Cell.new(grid.dig(y, x), coords)
  end

  def neighbours(coords)
    CARDINALS.map { |key, offset|
      [key, lookup(coords.zip(offset).map { |c, o| c + o })]
    }.to_h
  end

  def each
    cell = lookup(@start)
    directions = neighbours(cell.coords).select{|key, cell| INSTRUCTIONS.fetch(cell.value, {}).keys.include? key}.keys
    movers = directions.map{|d| Mover.new(cell, d)}
    while true
      yield movers.map{|m| m.cell.coords}
      movers = movers.map do |mover|
        cell = lookup(mover.cell.offset(CARDINALS[mover.direction]))
        direction = INSTRUCTIONS[cell.value][mover.direction]
        return if direction.nil?
        Mover.new(cell, direction)
      end
    end
  end
end

l = Loop.new(ARGF.readlines.map(&:strip).map { |l| l.split("") })

part1 = l.drop(1).take_while { |a, b| a != b }.length + 1

puts "Part 1: #{part1}"

loopCoords = l.map(&:first).to_a # TODO - no unpair the iterator

loopOnly = ""
l.grid.each_with_index do |row, y|
  loopOnlyRow = ""
  row.each_with_index do |cell, x|
    if loopCoords.include? [x, y]
      loopOnlyRow << l.lookup([x, y]).value
    else
      loopOnlyRow << '.'
    end
  end
  loopOnly << loopOnlyRow
  loopOnly << "\n"
end

puts loopOnly.gsub('L', '┗').gsub('J', '┛').gsub('7', '┓').gsub('F', '┏').gsub('|', '┃').gsub('-', '━')
puts

enclosedCounter = 0
loopOnly.split("\n").each do |row|
  crossings = row.gsub(/(F-*)J/, '\1|').gsub(/(L-*)7/, '\1|').gsub(/S/, '|').split("")
  counter = 0
  outRow = ""
  crossings.each do |cell|
    if cell == "|"
      counter += 1
      outRow << cell
    elsif cell == "."
      if counter.odd?
        outRow << "I"
        enclosedCounter += 1
      else
        outRow << "O"
      end
    else
      outRow << cell
    end
  end
  puts outRow
end

puts "Part 2: #{enclosedCounter}"