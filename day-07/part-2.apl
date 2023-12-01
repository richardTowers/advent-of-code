i ← ⍎⊃⊃⎕NGET'input.txt'1
⌊/+⌿{2÷⍨⍵×⍵+1}¨|i∘.-⍳⌈/i
