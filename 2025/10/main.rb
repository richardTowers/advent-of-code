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

def bfs(start, done, next_states)
  visited = Set.new
  queue = [start]
  next_queue = []

  steps = 0

  while !queue.empty?
    queue.each do |state|
      next if visited.include?(state)
      visited.add(state)

      return steps if done.call(state)

      next_states.call(state).each do |new_state|
        next_queue << new_state
      end
    end

    queue = next_queue
    next_queue = []
    steps += 1
  end
end

def joltage_levels(machine, counts)
  init = machine.joltage_reqs.map { 0 }
  machine.wirings.zip(counts).reduce(init) do |acc, (wiring, count)|
    wiring.each { |i| acc[i] += count }
    acc
  end
end

part_1 = input.sum do |machine|
           start = machine.target_state.map { ?. }
           done = lambda { |state| state == machine.target_state }
           next_states = lambda { |state| machine.wirings.map { |wiring| toggle_state(state, wiring) } }
           bfs(start, done, next_states)
         end

machine = input.first
start = machine.wirings.map { 0 }
done = lambda { |state| joltage_levels(machine, state) == machine.joltage_reqs }
next_states = lambda do |state|
                pp state
                state
                  .map.with_index { |c, i| new_state = state.dup; new_state[i] = c + 1; new_state }
                  .reject { |s| joltage_levels(machine, s).zip(machine.joltage_reqs).any? { |l, r| l > r } }
              end
part_2 = bfs(start, done, next_states)

pp [
  part_1,
  part_2,
]
