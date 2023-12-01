⍝ Assuming i is a vector containing the input
⎕IO←0
s ← 3
w ← +/⍉↑ (⍳s) {⍺↓(⍺-s)↓⍵}¨⊂i
+/(¯1↓w)<(1↓w)
