#!/usr/bin/env ruby

x = ARGF
    .read
    .split(",")
    .flat_map { Range.new(*it.chomp.split("-").map(&:to_i)).to_a }
    .select do |n|
      digits = n.to_s.length
      next if digits % 2 != 0

      left_half = n.to_s[0...digits/2]
      right_half = n.to_s[digits/2..]
      [left_half, right_half]
      left_half == right_half
    end.sum

pp x
  

