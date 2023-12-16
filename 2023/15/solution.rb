#!/usr/bin/env ruby
input = ARGF.read.split(",")
hashes = input.map{|string|
  string.split("").reduce(0){|acc, char| ((acc + char.ord) * 17) % 256 }
}
puts "Part 1: #{hashes.sum}"