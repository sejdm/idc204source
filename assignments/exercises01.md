---
title: Exercise sheet 1
---


1. Verify the following using truth tables:
   a) $P \lor P \land Q = P$
   b) $P \land (P \lor Q) = P$
   c) $P \lor (\neg P \land Q) = P \lor Q$

3. Find a boolean expression for the following truth table in terms of $\land$, $\lor$, and $\neg$ and then simplify it:

| $P$ | $Q$ | $R$ |   |
|-----|-----|-----|---|
| T   | T   | T   | T |
| T   | T   | F   | T |
| T   | F   | T   | F |
| T   | F   | F   | F |
| F   | T   | T   | F |
| F   | T   | F   | F |
| F   | F   | T   | F |
| F   | F   | F   | F |

4. Define the $\mathrm{NOR}$ operator by the rule, $P\ \mathrm{NOR}\ Q$ is true if and only if $P$ and $Q$ are both false.
	a) Write a truth table for $\mathrm{NOR}$.
    b) Find an expression for $P\ \mathrm{NOR}\ Q$ in terms of $\land$, $\lor$, and $\neg$.
    c) Prove that $\neg P$ can be defined completely in terms of $\mathrm{NOR}$ *(Hint: since $\mathrm{NOR}$ takes two arguments but $\neg P$ involves just one variable, there is only one thing you can do!).*
    d) Prove that $P \lor Q$ can be expressed using only the $\mathrm{NOR}$ operator. *(Hint: $\lor$ is the negation of $\mathrm{NOR}$ and part c. shows how to express negation in terms of $\mathrm{NOR}$).*
    e) Prove that $P \land Q$ can be expressed using only the $\mathrm{NOR}$ operator, and therefore, by c. and d. you can express any boolean function using only the $\mathrm{NOR}$ operator. *(Hint: compare the truth tables of $\land$ and $\mathrm{NOR}$. How do you get one from the other?)*

2. Simplify the following boolean expressions:
   a) $(\neg P \lor \neg Q) \land (\neg P \lor Q)$
   b) $\neg P \land \neg (P \lor Q)$



*To be completed...*
