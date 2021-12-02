lines = File.readlines('input.txt')
tuples = lines.map{|l| l.split(' ')}
sum_by_direction = tuples
  .group_by{|t| t[0]}
  .map{|g, values| [g, values.map{|v| v[1].to_i}.sum]}
  .to_h

part_1 = sum_by_direction["forward"] * (sum_by_direction["down"] - sum_by_direction["up"])
puts part_1
