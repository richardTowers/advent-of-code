⎕IO ← 0
input ← ⎕FIO[49] 'input.txt'
tuples ← {(' '≠⍵)⊂⍵}¨input
forwards ← 'f'=0⌷¨⊃0⌷¨tuples
ups ← 'u'=0⌷¨⊃0⌷¨tuples
downs ← 'd'=0⌷¨⊃0⌷¨tuples
forwardSum ← +/⍎¨⊃1⌷¨forwards / tuples
upSum ← +/⍎¨⊃1⌷¨ups / tuples
downSum ← +/⍎¨⊃1⌷¨downs / tuples

forwardSum × (downSum - upSum)
