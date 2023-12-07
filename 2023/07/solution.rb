#!/usr/bin/env ruby

Card = Data.define(:label) do
  def hex(mapping = "23456789TJQKA")
    mapping.index(label).to_s(16)
  end

  def hex_joker
    hex("J23456789TQKA")
  end
end

Hand = Data.define(:cards, :bid) do
  def bonus(joker = false)
    trick_score(trick_string)
  end

  def bonus_joker
    trick_score(trick_string_joker)
  end

  def score
    bonus + cards.map(&:hex).join("").to_i(16)
  end

  def score_joker
    bonus_joker + cards.map(&:hex_joker).join("").to_i(16)
  end

private

  def counts
    cards.each_with_object(Hash.new(0)) { |card, h| h[card.label] += 1 }
  end

  def trick_string
    counts.values.sort.join("")
  end

  def trick_string_joker
    c = counts
    jokerCount = c.delete("J") || 0
    maxOtherCount = c.max_by { |_k, v| v }
    if maxOtherCount.nil?
      c["J"] = jokerCount
    else
      c[maxOtherCount[0]] = maxOtherCount[1] + jokerCount unless maxOtherCount.nil?
    end
    c.values.sort.join("")
  end

  def trick_score(trickString)
    trickPatterns = [/5/, /4/, /23/, /3/, /22/, /2/, /1/]
    index = trickPatterns.index { |trickPattern| trickString =~ trickPattern }
    (7 - index) * 0x100000
  end
end

def winnings(sortedHands)
  sortedHands.map.with_index { |hand, index| hand.bid * (index + 1) }
end

lines = ARGF.readlines
hands = lines.map do |line|
  cardsStr, bidStr = line.split(" ")
  cards = cardsStr.split("").map { |c| Card.new(c) }
  Hand.new(cards, bidStr.to_i)
end

puts "Part 1: #{winnings(hands.sort_by(&:score)).sum}"
puts "Part 2: #{winnings(hands.sort_by(&:score_joker)).sum}"
