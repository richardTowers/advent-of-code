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

def toggle_joltage(state, wiring)
  new_state = state.dup
  wiring.each do |index|
    new_state[index] += 1
  end
  new_state
end

CACHE = {}
def dfs(start, target, depth = 0, &block)
  return [start] if start == target
  
  block.call(start).each do |new|
    result = dfs(new, target, depth + 1, &block)
    return [start, *result] if result
  end

  nil
end

def bfs(start, target, &block)
  visited = Set.new
  queue = [start]
  next_queue = []

  steps = 0

  while !queue.empty?
    queue.each do |state|
      next if visited.include?(state)
      visited.add(state)

      return steps if state == target

      block.call(state).each do |new_state|
        next_queue << new_state
      end
    end

    queue = next_queue
    next_queue = []
    steps += 1
  end
end

part_1 = input.sum do |machine|
           bfs(["."] * machine.target_state.count, machine.target_state) do |state|
             machine.wirings.map { |wiring| toggle_state(state, wiring) }
           end
         end

start = [0] * input.first.joltage_reqs.count
target = input.first.joltage_reqs
wirings = input.first.wirings
part_2 = dfs(start, target) do |state|
  wirings.map { |wiring| toggle_joltage(state, wiring) }
    .reject { |state| state.zip(target).any? { |l, r| l > r } }
end

pp [
  part_1,
  part_2,
]
