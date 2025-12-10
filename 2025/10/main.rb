#!/usr/bin/env ruby

Machine = Data.define(:target_state, :wirings, :joltage_reqs)

input = $<.map { it.split(" ") }.map do |row|
  Machine.new(
    target_state: row.first[1...-1].split(""),
    wirings: row[1...-1].map { it[1...-1].split(",").map(&:to_i) },
    joltage_reqs: row.last[1...-1].split(",").map(&:to_i)
  )
end

def toggle_state(state, wiring)
  new_state = state.dup
  wiring.each do |index|
    new_state[index] = case new_state[index]
                       in "." then "#"
                       in "#" then "."
                       end
  end
  new_state
end

def bfs(start, done, &block)
  visited = Set.new
  queue = [start]
  next_queue = []

  steps = 0

  while !queue.empty?
    queue.each do |state|
      next if visited.include?(state)
      visited.add(state)

      return steps if done.call(state)

      block.call(state).each do |new_state|
        next_queue << new_state
      end
    end

    queue = next_queue
    next_queue = []
    steps += 1
  end
end

def joltage_levels(wirings, counts)
  wirings.zip(counts).reduce(wirings.map { 0 }) do |acc, (wiring, count)|
    wiring.each { |i| acc[i] += count }
    acc
  end
end

part_1 = input.sum do |machine|
           start = machine.target_state.map { ?. }
           bfs(start, lambda { |state| state == machine.target_state }) do |state|
             machine.wirings.map { |wiring| toggle_state(state, wiring) }
           end
         end

part_2 = :TODO
# machine = input.first
# counter = machine.wirings.map { 0 }
# bfs(counter, 

pp [
  part_1,
  part_2,
]
