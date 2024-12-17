#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
input = ARGF.read

match = /Register A: (\d+)
Register B: (\d+)
Register C: (\d+)

Program: ([\d,]+)/.match(input)

a, b, c, prog = match[1..]
a, b, c = [a, b, c].map(&:to_i)
prog = prog.split(',').map(&:to_i).each_slice(2).to_a

def combo(operand, a, b, c)
  case operand
  in 0 | 1 | 2 | 3 then operand
  in 4 then a
  in 5 then b
  in 6 then c
  end
end

ip = 0
output = []
while ip < prog.length
  # NOTE: much easier to debug if we output things in base 8,
  # as there's a bunch of base 8 modular arithmetic
  puts <<~EOF
    ----
    Register A: #{a.to_s(8)}
    Register B: #{b.to_s(8)}
    Register C: #{c.to_s(8)}
    IP: #{ip}
    Output: #{output}
  EOF
  case prog[ip]
  in [0, operand] then a /= 2**combo(operand, a, b, c)
  in [1, operand] then b ^= operand
  in [2, operand] then b = combo(operand, a, b, c) % 8
  in [3, operand]
    if a != 0
      ip = operand
      next
    end
  in [4, _] then b ^= c
  in [5, operand] then output << combo(operand, a, b, c) % 8
  in [6, operand] then b = a / 2**combo(operand, a, b, c)
  in [7, operand] then c = a / 2**combo(operand, a, b, c)
  end
  ip += 1
end

# Part 1
part1 = output.join(',')

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
