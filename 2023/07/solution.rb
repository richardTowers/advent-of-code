#!/usr/bin/env ruby

Card = Data.define(:label) do
  def hex(joker = nil)
    mapping = "23456789TJQKA"
    if joker
      mapping = joker + mapping.sub(joker, "")
    end
    mapping.index(label).to_s(16)
  end
end

Hand = Data.define(:cards, :bid, :joker) do
  def bonus
    counts = cards.each_with_object(Hash.new(0)) { |card, h| h[card.label] += 1 }
    if joker
      jokerCount = counts.delete(joker) || 0
      maxOtherCount = counts.max_by { |_k, v| v }
      if maxOtherCount.nil?
        counts["J"] = jokerCount
      else
        counts[maxOtherCount[0]] = maxOtherCount[1] + jokerCount unless maxOtherCount.nil?
      end
    end
    trickString = counts.values.sort.join("")
    trickPatterns = [/5/, /4/, /23/, /3/, /22/, /2/, /1/]
    index = trickPatterns.index { |trickPattern| trickString =~ trickPattern }
    (7 - index) * 0x100000
  end

  def score
    bonus + cards.map { |c| c.hex(joker) }.join("").to_i(16)
  end
end

def winnings(hands)
  hands.sort_by(&:score).map.with_index { |hand, index| hand.bid * (index + 1) }
end

lines = ARGF.readlines
hands = lines.map do |line|
  cardsStr, bidStr = line.split(" ")
  cards = cardsStr.split("").map { |c| Card.new(c) }
  Hand.new(cards, bidStr.to_i, nil)
end

part1 = winnings(hands).sum
puts "Part 1: #{part1}"
part2 = winnings(hands.map { |h| Hand.new(h.cards, h.bid, "J") }).sum
puts "Part 2: #{part2}"
