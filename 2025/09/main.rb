#!/usr/bin/env ruby

# TODO:
# - Switch from complex numbers to Point / Line / Rect
# - Implement a method to check if two lines intersect
# - Implement a method on Rect to get four inner line segments (just inside the corners)
# - Implement a method to check if a point is inside the shape (vector from 0,0 has an odd number of intersections with the walls)
# - For each Rect
#   - Check if both corners are inside the shape
#   - Check that no walls intersect the inscribed rect
# - For the remaining Rects, get the largest area

corners = $<.map { |line| line.split(",").map(&:to_i) }.map { |x, y| x + 1i * y}

part_1 = corners
  .combination(2)
  .map { |z1, z2| (z2.real - z1.real).abs.next * (z2.imag - z1.imag).abs.next }
  .sort
  .last

walls = (corners + [corners.first]).each_cons(2).to_a

part_2 = corners
  .permutation(2)
  .select { |z1, z2|
    # TODO
    false
  }
  .map { |z1, z2| (z2.real - z1.real).abs.next * (z2.imag - z1.imag).abs.next }
  .sort
  .last

pp [
  part_1,
  part_2,
]
