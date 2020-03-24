---
title: "Turing machine example: Equality"
date: 23 March, 2020
---

# Checking for equality

This state transition table checks if the string ...=... is correct. It doees so by repeatedly marking a character that it will search for, then hunts for = symbol and then begins searching for the first non marked character and checks for equality.

Note that the the alphabet is merely $\{0, 1, =\}$, but the tape alphabet also includes X to mark the characters that have been tested.

label: equal
| equal    | 0            | 1             | X             | =            |         |
|----------|--------------|---------------|---------------|--------------|---------|
| $q_0$    | $q_f$,X,R    | $q_{ff}$,X,R  | $q_0$,X,R     | acc,=,R      | re,=,L  |
| $q_f$    | $q_f$,0,R    | $q_f$,1,R     | $q_f$,1,R     | $q_o$,=,R    | re,=,L  |
| $q_o$    | $q_{be}$,X,R | re,1,R        | $q_o$,X,R     | re,=,R       | re,=,L  |
| $q_{ff}$ | $q_{ff}$,0,R | $q_{ff}$,1 ,R | $q_{ff}$ ,X,R | $q_{oo}$,=,R | re,=,L  |
| $q_{oo}$ | re,0,R       | $q_{be}$,X,R  | $q_{oo}$,X,R  | re,=,R       | re,=,L  |
| $q_{be}$ | $q_{be}$,0,L | $q_{be}$,1,L  | $q_{be}$,X,L  | $q_{bf}$,=,L | acc,E,R |
| $q_{bf}$ | $q_{bf}$,0,L | $q_{bf}$,1,L  | $q_0$,X,R     | re,=,R       | acc,=,R |

Here you can see the steps of the Turing machine.

<<equal>>: 1011=1011

<<equal>>: 1011=1111
