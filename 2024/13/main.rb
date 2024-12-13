#!/usr/bin/env ruby
# frozen_string_literal: true

# Definitions
BUTTON_A_COST = 3
BUTTON_B_COST = 1
Node = Data.define(:coord, :cost, :parent)
Machine = Data.define(:button_a, :button_b, :prize)

def build_button(line)
  button_pattern = /Button .: X\+(?<x>\d+), Y\+(?<y>\d+)/
  x, y = button_pattern.match(line).values_at(:x, :y).map(&:to_i)
  x + 1i * y
end

def build_prize(line)
  prize_pattern = /Prize: X=(?<x>\d+), Y=(?<y>\d+)/
  x, y = prize_pattern.match(line).values_at(:x, :y).map(&:to_i)
  x + 1i * y
end

def dijkstra(machine)
  nodes = {}
  nodes[0] = Node.new(coord: 0, cost: 0, parent: nil)

  until nodes.empty?
    _, v = nodes.min_by { _2.cost }
    nodes.delete(v.coord)
    return v if v.coord == machine.prize
    next if v.coord.real > machine.prize.real || v.coord.imag > machine.prize.imag

    # TODO: deduplicate this
    a = v.coord + machine.button_a
    a_prev_cost = nodes[a]&.cost || Float::INFINITY
    a_cost = [v.cost + BUTTON_A_COST, a_prev_cost].min
    a_node = Node.new(coord: a, cost: a_cost, parent: v)
    nodes[a] = a_node

    b = v.coord + machine.button_b
    b_prev_cost = nodes[b]&.cost || Float::INFINITY
    b_cost = [v.cost + BUTTON_B_COST, b_prev_cost].min
    b_node = Node.new(coord: b, cost: b_cost, parent: v)
    nodes[b] = b_node
  end

  nil
end

# Parse input
lines = ARGF.readlines
machines = lines.each_slice(4).map do |a_line, b_line, prize_line, _|
  Machine.new(
    build_button(a_line),
    build_button(b_line),
    build_prize(prize_line)
  )
end

prizes = machines.map.with_index { puts _2; dijkstra(_1) }

# Part 1
part1 = prizes.compact.sum(&:cost)

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
