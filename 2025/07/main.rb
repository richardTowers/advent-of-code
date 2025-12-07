#!/usr/bin/env ruby

beams = Set.new
splits = 0
$<.each do |line|
  beams << line.index(?S) if line =~ /S/
  beams.map { [it, line[it]] }.each do |beam, cell|
    if cell == ?^
      splits += 1
      beams.delete(beam)
      beams << beam - 1 << beam + 1 
    end
  end
  beams.each { line[it] = "|" }
  puts line
end

pp splits
