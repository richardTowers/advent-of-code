⎕IO ← 0

i ← {(⍎⊃⍵[0]) (⍎⊃⍵[2])}¨' '(≠⊆⊢)¨⊃⎕NGET'input.txt'1
vs ← ({(0⌷⊃0⌷⍵)=(0⌷⊃1⌷⍵)}¨i)/i
hs ← ({(1⌷⊃0⌷⍵)=(1⌷⊃1⌷⍵)}¨i)/i

board ← 1000 1000 ⍴ 0

f ← {indexes ← ⍵[⍋⍵] ⋄ select ← indexes[0]+⍸((⊃indexes[1]-indexes[0])+1)⍴1 ⋄ board[⌽¨select] ← board[⌽¨select] + 1}
⍝ Add the horizontals
f¨hs

⍝ Add the verticals
f¨vs

+/+/board > 1

