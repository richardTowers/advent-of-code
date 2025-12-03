#!/usr/bin/env ruby

banks = ARGF.readlines.map(&:chomp).map { it.split("") }

pp (banks.sum do |bank|
  lmax = bank[...-1].max
  lindex = bank.index(lmax)
  rmax = bank[lindex+1..].max
  (lmax + rmax).to_i
end)

