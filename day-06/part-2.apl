⎕PP←13
i ← ⍎⊃⊃⎕NGET'input.txt'1
x←256{t←⍵[⍋⍵;]⋄t[;1]←t[;1]-1⋄t[8;2]←t[8;2]+t[1;2]⋄t←t,[1](8 (t[1;2]))⋄t←1↓t⋄⍺=1:t⋄(⍺-1)∇t}({⍺(≢⍵)}⌸i),[1]⍉↑(0,(5+⍳3))(4⍴0)
+/x[;2]
