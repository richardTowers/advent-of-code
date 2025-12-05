#!/usr/bin/env ruby

def fixed_point(x, &block)
  block.call(x).then { it == x ? it : fixed_point(it, &block) }
end

def combine_ranges(ranges)
  overlaps = ranges
    .combination(2)
    .select { |l, r| l.overlap?(r) }
    .map { |l, r| ([l.begin, r.begin].min..[l.end, r.end].max) }
    .uniq
  ranges.reject { |r| overlaps.any? { |o| o.overlap?(r) } } + overlaps
end

input = ARGF.read.split("\n\n").map(&:split)
ranges = input[0].map { Range.new(*it.split("-").map(&:to_i)) }
ids = input[1].map(&:to_i)

part_1 = ids.count { |id| ranges.any? { |range| range.include?(id) } }

combined_ranges = fixed_point(ranges) { combine_ranges(it) }

part_2 = combined_ranges.sum(&:size)

pp [
  part_1,
  part_2,
]

