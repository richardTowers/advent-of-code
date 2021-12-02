$depth = 0; $position = 0; $aim = 0;
def down(n); $aim = $aim + n; end
def up(n); $aim = $aim - n; end
def forward(n); $position = $position + n; $depth = $depth + $aim * n; end
File.readlines('input.txt').each{|l|eval(l)}
puts $depth * $position
