#!/usr/bin/env ruby

lines = ARGF.readlines.map(&:chomp)

Card = Struct.new(:number, :winning_numbers, :actual_numbers) do
  def actual_winning_numbers
    @actual_winning_numbers ||= winning_numbers.intersection(actual_numbers)
  end

  def points
    return 0 if actual_winning_numbers.empty?

    2**(actual_winning_numbers.length - 1)
  end

  def following_range
    @following_range ||= ((number + 1)...(number + actual_winning_numbers.length + 1))
  end
end

original_cards = lines.map do |line|
  card_str, rest = line.split(":")
  winning_str, actual_str = rest.split("|")
  card_number = card_str.match(/\d+/)[0].to_i
  winning_numbers = winning_str.scan(/\d+/).map(&:to_i)
  actual_numbers = actual_str.scan(/\d+/).map(&:to_i)
  Card.new(card_number, winning_numbers, actual_numbers)
end

puts "Part 1: #{original_cards.map(&:points).sum}"

cards_by_card_number = original_cards.map{|c| [c.number, c]}.to_h

cards_and_copies = original_cards
cards_and_copies.each do |card|
  cards_to_add = card.following_range.map { |n| cards_by_card_number[n] }
  cards_and_copies.push(*cards_to_add)
end

puts "Part 2: #{cards_and_copies.length}"
