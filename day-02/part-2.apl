⍝ All credit to https://github.com/jayfoad/aoc2021apl/blob/main/p2.dyalog
⍝ This solution is basically a long winded copy of that.
⍝
⍝ The general idea is to treat the input itself as the program :big-brain:
⍝
⍝ We define functions "forward", "down" and "up", and then evaluate each line of the input.
⍝
⍝ Assuming input is a vector containing the input

depth ← 0 ⋄ position ← 0 ⋄ aim ← 0
down ← {aim+←⍵}
up ← {aim-←⍵}
forward ← {position+←⍵⋄depth+←aim×⍵}

⍝ Evaluate each line of the input
⍎¨input

⍝ The answer to the puzzle is depth × position
depth × position


