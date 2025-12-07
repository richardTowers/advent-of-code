#!/usr/bin/env ruby

lines = $<.readlines
beams = Set.new
splits = 0
lines.each do |line|
  beams << line.index(?S) if line =~ /S/
  beams.map { [it, line[it]] }.each do |beam, cell|
    if cell == ?^
      splits += 1
      beams.delete(beam)
      beams << beam - 1 << beam + 1 
    end
  end
end
part_1 = splits

CACHE = {}
def count_paths(beam, manifold)
  return 1 if manifold == []
  
  key = [beam, manifold.length]
  return CACHE[key] if CACHE.key? key

  beams = manifold.first[beam] == ?^ ? [beam - 1, beam + 1] : [beam]
  CACHE[key] = beams.sum { |b| count_paths(b, manifold[1..]) }
end
part_2 = count_paths(lines.first.index(?S), lines)

pp [
  part_1,
  part_2,
]

