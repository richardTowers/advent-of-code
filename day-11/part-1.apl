i ← ↑⍎¨¨⊃⎕NGET'input.txt'1
flash ← { f a ← ⍵ ⋄ f ← (f ∨ 9<a) ⋄ fnc ← (⊃+/+⌿0 ¯1 ¯2∘.⊖0 ¯1 ¯2⌽¨⊂(2+⍴a)↑a>9)[(⊂1 1)+⍳(⍴a)] ⋄ res ← (~f)∧(a + fnc) ⋄ (f res) }
step ← { c a ← ⍵ ⋄ res ← flash ⍣≡ ((⍴a)⍴0) (a + 1) ⋄ (c + +/+⌿⊃res[1]) (⊃res[2]) }
(step⍣100) 0 i

