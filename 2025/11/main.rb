#!/usr/bin/env ruby

GRAPH = Hash.new { [] }
$<.map { it.split(?:) }.each { GRAPH[_1] = _2.strip.split(" ") }

CACHE = {}
def dfs(start, targets)
  current_target, *remainder = targets
  return remainder.empty? ? 1 : dfs(current_target, remainder) if start == current_target

  CACHE[[start, targets]] ||= GRAPH[start].sum { |node| dfs(node, targets) }
end

part_1 = dfs("you", ["out"])
part_2 = [["fft", "dac", "out"],["dac", "fft", "out"]].sum { |path| dfs("svr", path) }

pp [
  part_1,
  part_2,
]

