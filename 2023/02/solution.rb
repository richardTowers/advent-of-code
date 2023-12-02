#!/usr/bin/env ruby

require 'strscan'

def parse_count(scanner)
  scanner.scan(/ *(\d+) (\w+)/)
  return nil unless scanner.matched?

  count = scanner[1].to_i
  colour = scanner[2]
  { colour:, count: }
end

def parse_hand(scanner)
  counts = Hash.new(0)
  while (count = parse_count(scanner))
    counts[count[:colour]] = count[:count]
    scanner.skip(/,/)
  end
  return nil if counts.empty?

  counts
end

def parse_line(input)
  scanner = StringScanner.new(input)
  scanner.scan(/Game (\d+): /)
  return nil unless scanner.matched?

  game_id = scanner[1].to_i
  hands = []
  while (hand = parse_hand(scanner))
    hands << hand
    scanner.skip(/;/)
  end
  { game_id:, hands: }
end

lines = ARGF.readlines
games = lines.map { |line| parse_line(line) }

rgb = %w[red green blue]
limits = [12, 13, 14]
possible_games = games.select do |game|
  game[:hands].all? do |hand|
    hand.values_at(*rgb).zip(limits).all? { |l, r| l <= r }
  end
end

maximums = games.map do |game|
  game[:hands].each_with_object(Hash.new(0)) do |hand, max|
    rgb.each { |c| max[c] = hand[c] if hand[c] > max[c] }
  end
end

part1 = possible_games.sum { |game| game[:game_id] }
part2 = maximums.map { |ms| ms.values.inject(:*) }.sum

puts part1
puts part2
