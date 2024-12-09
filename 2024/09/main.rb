#!/usr/bin/env ruby
# frozen_string_literal: true

# Definitions
FileBlocks = Data.define(:id, :length)
FreeSpace = Data.define(:length)

# Parse input
input = ARGF.read.chomp.split('').map(&:to_i)
disk = input.map.with_index do |x, i|
  if i.even?
    FileBlocks.new(i / 2, x)
  else
    FreeSpace.new(x)
  end
end

def defrag(disk)
  case disk
  in [] then []
  in [FreeSpace] then disk
  in [FileBlocks => head, *tail] # Ignore leading file blocks
    [head, *defrag(tail)]
  in [*rest, FreeSpace => tail_free_space] # Ignore trailing space
    [*defrag(rest), tail_free_space]
  in [*rest, FileBlocks => file_blocks]
    i = rest.index { _1.is_a?(FreeSpace) && _1.length >= file_blocks.length }
    if i.nil?
      [*defrag(rest), file_blocks]
    else
      space = rest[i]
      inter = if space.length == file_blocks.length
                [file_blocks]
              else
                [file_blocks, FreeSpace.new(space.length - file_blocks.length)]
              end
      defrag(rest[0...i] + inter + rest[(i + 1)..] + [FreeSpace.new(file_blocks.length)])
    end
  end
end

pos = 0
total = 0
defrag(disk).each do |segment|
  total += case segment
           when FreeSpace then 0
           when FileBlocks
             # TODO: do this more efficiently
             (pos...pos + segment.length).sum { _1 * segment.id }
           end
  pos += segment.length
end.to_a

# Part 1
part1 = nil

# Part 2
part2 = total

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
