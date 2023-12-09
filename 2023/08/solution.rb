#!/usr/bin/env ruby

lines = ARGF.readlines
directions = lines[0].strip.split('')
graph = lines[2..].map{ |line|
  key, rest = line.split("=").map(&:strip)
  left, right = rest.scan /[A-Z0-9]+/
  [key, {"L" => left, "R" => right}]
}.to_h

i = 0
node = "AAA"
while node != "ZZZ" do
  d = directions[i % directions.length]
  node = graph[node][d]
  i += 1
end
puts "Part 1: #{i}"
