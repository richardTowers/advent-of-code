⍝ Assuming input is a vector containing the input

oxy ← {⍺←0⋄1≥⊃⍴⍵:⍵ ⋄ i ← ⍎¨⍺⌷¨⍵ ⋄ b ← 0.5≤(+/i)÷⊃⍴⍵ ⋄ mask ← b=i ⋄ next ← mask/⍵ ⋄ (⍺+1) ∇ next}
co2 ← {⍺←0⋄1≥⊃⍴⍵:⍵ ⋄ i ← ⍎¨⍺⌷¨⍵ ⋄ b ← 0.5>(+/i)÷⊃⍴⍵ ⋄ mask ← b=i ⋄ next ← mask/⍵ ⋄ (⍺+1) ∇ next}
(2⊥⍎¨⊃oxy input)×(2⊥⍎¨⊃co2 input)

