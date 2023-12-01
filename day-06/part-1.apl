⎕IO ← 0
i ← ⍎⊃⊃⎕NGET'input.txt'1
⍴80{n←⍵-1⋄z←⍸¯1=n⋄n[z]←6⋄n←n,(⍴z)⍴8⋄⍺=1:n⋄(⍺-1)∇n}i
