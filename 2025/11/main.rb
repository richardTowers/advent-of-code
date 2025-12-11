#!/usr/bin/env ruby

input = $<.map { it.split(?:) }.to_h { [_1, _2.strip.split(" ")] }

CACHE = {}
def dfs(start, targets, &block)
  target, *remainder = targets
  key = [start, targets]
  return CACHE[key] if CACHE.key?(key)
  if start == target
    return 1 if remainder.empty?
    return dfs(target, remainder, &block)
  end

  ids = block.call(start)
  CACHE[key] = ids.nil? ? 0 : ids.sum { dfs(it, targets, &block) }
end

part_1 = dfs("you", ["out"]) { input[it] }
a = dfs("svr", ["fft", "dac", "out"]) { input[it] }
b = dfs("svr", ["dac", "fft", "out"]) { input[it] }
part_2 = a + b

pp [
  part_1,
  part_2,
]

