---
title: "Turing machine example: Equality"
date: 23 March, 2020
---

# Checking for equality

This state transition table checks if the string ...=... is correct. It doees so by repeatedly marking a character that it will search for, then hunts for = symbol and then begins searching for the first non marked character and checks for equality.

Note that the the alphabet is merely $\{0, 1, =\}$, but the tape alphabet also includes X to mark the characters that have been tested.

|  |0|1|X|=|_ |
|--|-|-|-|-|-|
| $q_0$|($q_f$, X, R)|($q_{ff}$, X, R)|($q_0$, X, R)|(Accept, =, R)|(Reject, =, L) |
| $q_f$|($q_f$, 0, R)|($q_f$, 1, R)|($q_f$, 1, R)|($q_o$, =, R)|(Reject, =, L) |
| $q_o$|($q_{be}$, X, R)|(Reject, 1, R)|($q_o$, X, R)|(Reject, =, R)|(Reject, =, L) |
| $q_{ff}$|($q_{ff}$, 0, R)|($q_{ff}$, 1, R)|($q_{ff}$, X, R)|($q_{oo}$, =, R)|(Reject, =, L) |
| $q_{oo}$|(Reject, 0, R)|($q_{be}$, X, R)|($q_{oo}$, X, R)|(Reject, =, R)|(Reject, =, L) |
| $q_{be}$|($q_{be}$, 0, L)|($q_{be}$, 1, L)|($q_{be}$, X, L)|($q_{bf}$, =, L)|(Accept, E, R) |
| $q_{bf}$|($q_{bf}$, 0, L)|($q_{bf}$, 1, L)|($q_0$, X, R)|(Reject, =, R)|(Accept, =, R) |
Here you can see the steps of the Turing machine.

input: 1011=1011

`Tape: |1| 0  1  1  =  1  0  1  1 ...`    $\delta$($q_0$, 1) = ($q_{ff}$, X, R)    
`Tape:  X |0| 1  1  =  1  0  1  1 ...`    $\delta$($q_{ff}$, 0) = ($q_{ff}$, 0, R)    
`Tape:  X  0 |1| 1  =  1  0  1  1 ...`    $\delta$($q_{ff}$, 1) = ($q_{ff}$, 1, R)    
`Tape:  X  0  1 |1| =  1  0  1  1 ...`    $\delta$($q_{ff}$, 1) = ($q_{ff}$, 1, R)    
`Tape:  X  0  1  1 |=| 1  0  1  1 ...`    $\delta$($q_{ff}$, =) = ($q_{oo}$, =, R)    
`Tape:  X  0  1  1  = |1| 0  1  1 ...`    $\delta$($q_{oo}$, 1) = ($q_{be}$, X, R)    
`Tape:  X  0  1  1  =  X |0| 1  1 ...`    $\delta$($q_{be}$, 0) = ($q_{be}$, 0, L)    
`Tape:  X  0  1  1  = |X| 0  1  1 ...`    $\delta$($q_{be}$, X) = ($q_{be}$, X, L)    
`Tape:  X  0  1  1 |=| X  0  1  1 ...`    $\delta$($q_{be}$, =) = ($q_{bf}$, =, L)    
`Tape:  X  0  1 |1| =  X  0  1  1 ...`    $\delta$($q_{bf}$, 1) = ($q_{bf}$, 1, L)    
`Tape:  X  0 |1| 1  =  X  0  1  1 ...`    $\delta$($q_{bf}$, 1) = ($q_{bf}$, 1, L)    
`Tape:  X |0| 1  1  =  X  0  1  1 ...`    $\delta$($q_{bf}$, 0) = ($q_{bf}$, 0, L)    
`Tape: |X| 0  1  1  =  X  0  1  1 ...`    $\delta$($q_{bf}$, X) = ($q_0$, X, R)    
`Tape:  X |0| 1  1  =  X  0  1  1 ...`    $\delta$($q_0$, 0) = ($q_f$, X, R)    
`Tape:  X  X |1| 1  =  X  0  1  1 ...`    $\delta$($q_f$, 1) = ($q_f$, 1, R)    
`Tape:  X  X  1 |1| =  X  0  1  1 ...`    $\delta$($q_f$, 1) = ($q_f$, 1, R)    
`Tape:  X  X  1  1 |=| X  0  1  1 ...`    $\delta$($q_f$, =) = ($q_o$, =, R)    
`Tape:  X  X  1  1  = |X| 0  1  1 ...`    $\delta$($q_o$, X) = ($q_o$, X, R)    
`Tape:  X  X  1  1  =  X |0| 1  1 ...`    $\delta$($q_o$, 0) = ($q_{be}$, X, R)    
`Tape:  X  X  1  1  =  X  X |1| 1 ...`    $\delta$($q_{be}$, 1) = ($q_{be}$, 1, L)    
`Tape:  X  X  1  1  =  X |X| 1  1 ...`    $\delta$($q_{be}$, X) = ($q_{be}$, X, L)    
`Tape:  X  X  1  1  = |X| X  1  1 ...`    $\delta$($q_{be}$, X) = ($q_{be}$, X, L)    
`Tape:  X  X  1  1 |=| X  X  1  1 ...`    $\delta$($q_{be}$, =) = ($q_{bf}$, =, L)    
`Tape:  X  X  1 |1| =  X  X  1  1 ...`    $\delta$($q_{bf}$, 1) = ($q_{bf}$, 1, L)    
`Tape:  X  X |1| 1  =  X  X  1  1 ...`    $\delta$($q_{bf}$, 1) = ($q_{bf}$, 1, L)    
`Tape:  X |X| 1  1  =  X  X  1  1 ...`    $\delta$($q_{bf}$, X) = ($q_0$, X, R)    
`Tape:  X  X |1| 1  =  X  X  1  1 ...`    $\delta$($q_0$, 1) = ($q_{ff}$, X, R)    
`Tape:  X  X  X |1| =  X  X  1  1 ...`    $\delta$($q_{ff}$, 1) = ($q_{ff}$, 1, R)    
`Tape:  X  X  X  1 |=| X  X  1  1 ...`    $\delta$($q_{ff}$, =) = ($q_{oo}$, =, R)    
`Tape:  X  X  X  1  = |X| X  1  1 ...`    $\delta$($q_{oo}$, X) = ($q_{oo}$, X, R)    
`Tape:  X  X  X  1  =  X |X| 1  1 ...`    $\delta$($q_{oo}$, X) = ($q_{oo}$, X, R)    
`Tape:  X  X  X  1  =  X  X |1| 1 ...`    $\delta$($q_{oo}$, 1) = ($q_{be}$, X, R)    
`Tape:  X  X  X  1  =  X  X  X |1|...`    $\delta$($q_{be}$, 1) = ($q_{be}$, 1, L)    
`Tape:  X  X  X  1  =  X  X |X| 1 ...`    $\delta$($q_{be}$, X) = ($q_{be}$, X, L)    
`Tape:  X  X  X  1  =  X |X| X  1 ...`    $\delta$($q_{be}$, X) = ($q_{be}$, X, L)    
`Tape:  X  X  X  1  = |X| X  X  1 ...`    $\delta$($q_{be}$, X) = ($q_{be}$, X, L)    
`Tape:  X  X  X  1 |=| X  X  X  1 ...`    $\delta$($q_{be}$, =) = ($q_{bf}$, =, L)    
`Tape:  X  X  X |1| =  X  X  X  1 ...`    $\delta$($q_{bf}$, 1) = ($q_{bf}$, 1, L)    
`Tape:  X  X |X| 1  =  X  X  X  1 ...`    $\delta$($q_{bf}$, X) = ($q_0$, X, R)    
`Tape:  X  X  X |1| =  X  X  X  1 ...`    $\delta$($q_0$, 1) = ($q_{ff}$, X, R)    
`Tape:  X  X  X  X |=| X  X  X  1 ...`    $\delta$($q_{ff}$, =) = ($q_{oo}$, =, R)    
`Tape:  X  X  X  X  = |X| X  X  1 ...`    $\delta$($q_{oo}$, X) = ($q_{oo}$, X, R)    
`Tape:  X  X  X  X  =  X |X| X  1 ...`    $\delta$($q_{oo}$, X) = ($q_{oo}$, X, R)    
`Tape:  X  X  X  X  =  X  X |X| 1 ...`    $\delta$($q_{oo}$, X) = ($q_{oo}$, X, R)    
`Tape:  X  X  X  X  =  X  X  X |1|...`    $\delta$($q_{oo}$, 1) = ($q_{be}$, X, R)    
`Tape:  X  X  X  X  =  X  X  X  X | |...`    $\delta$($q_{be}$, _) = (Accept, E, R)    
`Tape:  X  X  X  X  =  X  X  X  X  E | |...`    Accept    



input: 1011=1111

`Tape: |1| 0  1  1  =  1  1  1  1 ...`    $\delta$($q_0$, 1) = ($q_{ff}$, X, R)    
`Tape:  X |0| 1  1  =  1  1  1  1 ...`    $\delta$($q_{ff}$, 0) = ($q_{ff}$, 0, R)    
`Tape:  X  0 |1| 1  =  1  1  1  1 ...`    $\delta$($q_{ff}$, 1) = ($q_{ff}$, 1, R)    
`Tape:  X  0  1 |1| =  1  1  1  1 ...`    $\delta$($q_{ff}$, 1) = ($q_{ff}$, 1, R)    
`Tape:  X  0  1  1 |=| 1  1  1  1 ...`    $\delta$($q_{ff}$, =) = ($q_{oo}$, =, R)    
`Tape:  X  0  1  1  = |1| 1  1  1 ...`    $\delta$($q_{oo}$, 1) = ($q_{be}$, X, R)    
`Tape:  X  0  1  1  =  X |1| 1  1 ...`    $\delta$($q_{be}$, 1) = ($q_{be}$, 1, L)    
`Tape:  X  0  1  1  = |X| 1  1  1 ...`    $\delta$($q_{be}$, X) = ($q_{be}$, X, L)    
`Tape:  X  0  1  1 |=| X  1  1  1 ...`    $\delta$($q_{be}$, =) = ($q_{bf}$, =, L)    
`Tape:  X  0  1 |1| =  X  1  1  1 ...`    $\delta$($q_{bf}$, 1) = ($q_{bf}$, 1, L)    
`Tape:  X  0 |1| 1  =  X  1  1  1 ...`    $\delta$($q_{bf}$, 1) = ($q_{bf}$, 1, L)    
`Tape:  X |0| 1  1  =  X  1  1  1 ...`    $\delta$($q_{bf}$, 0) = ($q_{bf}$, 0, L)    
`Tape: |X| 0  1  1  =  X  1  1  1 ...`    $\delta$($q_{bf}$, X) = ($q_0$, X, R)    
`Tape:  X |0| 1  1  =  X  1  1  1 ...`    $\delta$($q_0$, 0) = ($q_f$, X, R)    
`Tape:  X  X |1| 1  =  X  1  1  1 ...`    $\delta$($q_f$, 1) = ($q_f$, 1, R)    
`Tape:  X  X  1 |1| =  X  1  1  1 ...`    $\delta$($q_f$, 1) = ($q_f$, 1, R)    
`Tape:  X  X  1  1 |=| X  1  1  1 ...`    $\delta$($q_f$, =) = ($q_o$, =, R)    
`Tape:  X  X  1  1  = |X| 1  1  1 ...`    $\delta$($q_o$, X) = ($q_o$, X, R)    
`Tape:  X  X  1  1  =  X |1| 1  1 ...`    $\delta$($q_o$, 1) = (Reject, 1, R)    
`Tape:  X  X  1  1  =  X  1 |1| 1 ...`    Reject    


