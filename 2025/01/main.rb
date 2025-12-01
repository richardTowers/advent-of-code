#!/usr/bin/env ruby

input = ARGF.readlines.map { it.sub(?L, ?-).sub(?R, ?+) }.map(&:to_i)
positions = input.reduce([50]) { |acc, n| acc << acc.last + n }

pp [
  positions.count { (it % 100).zero? },
  positions
    .each_cons(2)
    .sum { |l, r| Range.new(*[l+(r<=>l),r].sort).count { (it % 100).zero? } }
]

