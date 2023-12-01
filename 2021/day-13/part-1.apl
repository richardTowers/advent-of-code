⎕IO ← 0
i ← ⊃⎕NGET'input.txt'1
c f ← i⊆⍨''∘≢¨i
coords ← ⍎¨c
grid ← 0⍴⍨1+⊃⌈/coords
grid[coords] ← 1
foldX ← {(⍺↑[0]⍵) ∨ ⊖(-⍺)↑[0]⍵}
foldY ← {(⍺↑[1]⍵) ∨ ⌽(-⍺)↑[1]⍵}
⍎¨{d n ← '='(≠⊆⊢)⍵ ⋄ 'x' ∊ d:'grid←',n,' foldX grid' ⋄ 'grid←',n,' foldY grid' }¨f[0]
+/+⌿grid
