⍝ Assuming i is a vector containing the input
s ← 3
w ← +/⍉↑ (⍳s) {⍺↓(⍺-s)↓⍵}¨⊂i
+/(¯1↓w)<(1↓w)
