def solve(input, window_size)
  input
    .each_cons(window_size)
    .map(&:sum)
    .each_cons(2)
    .select{|l,r|l<r}
    .size
end

input = File.readlines('input.txt').map(&:to_i)
puts solve(input, 1)
puts solve(input, 3)
