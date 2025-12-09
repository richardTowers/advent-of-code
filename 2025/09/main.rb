#!/usr/bin/env ruby

pp(
  $<
    .map { |line| line.split(",").map(&:to_i) }.map { |x, y| x + 1i * y }
    .combination(2)
    .map { |z1, z2| (z2.real - z1.real).abs.next * (z2.imag - z1.imag).abs.next }
    .sort
    .last
)

