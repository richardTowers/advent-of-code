#!/usr/bin/env ruby
# frozen_string_literal: true

# Definitions
FileBlocks = Data.define(:id, :length)
FreeSpace = Data.define(:length)

# Parse input
input = ARGF.read.chomp.split('').map(&:to_i)
disk = input.map.with_index do |x, i|
  if i.even?
    FileBlocks.new(i/2, x)
  else
    FreeSpace.new(x)
  end
end

def defrag(disk)
  case disk
  in [] then []
  in [FreeSpace] then disk
  in [FileBlocks => head, *tail]
    [head, *defrag(tail)]
  in [FreeSpace => head_free_space, *rest, FreeSpace => tail_free_space]
    [*defrag([head_free_space, *rest]), tail_free_space]
  in [FreeSpace => free_space, *rest, FileBlocks => file_blocks]
    if free_space.length == file_blocks.length
      [file_blocks, *defrag(rest)]
    elsif free_space.length > file_blocks.length
      remaining_space = FreeSpace.new(free_space.length - file_blocks.length)
      [file_blocks, *defrag([remaining_space, *rest])]
    else
      eaten_file_blocks = FileBlocks.new(file_blocks.id, free_space.length)
      remaining_file_blocks = FileBlocks.new(file_blocks.id, file_blocks.length - free_space.length)
      [eaten_file_blocks, *defrag([*rest, remaining_file_blocks])]
    end
  end
end

pos = 0
total = 0
defrag(disk).each_with_index do |segment, i|
  total += case segment
           when FreeSpace then 0
           when FileBlocks then (pos...pos + segment.length).sum { _1 * segment.id }
           end
  pos += segment.length
end.to_a

# Part 1
part1 = total

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
