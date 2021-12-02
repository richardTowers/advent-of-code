$depth = 0; $position = 0; $aim = 0;
def down(n); $aim += n; end
def up(n); $aim -= n; end
def forward(n); $position += n; $depth += $aim * n; end
eval(File.read('input.txt'))
puts $depth * $position
