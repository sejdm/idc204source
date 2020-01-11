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

5. Write truth tables for the following expressions and based on that try to guess an equivalent but simpler expression (involving fewer terms):
   a) $P \land P$
   a) $P \lor P$
   a) $P \land (P \lor Q)$
   a) $P \lor (P \land Q)$
   a) $T \land A$
   a) $F \land A$
   a) $T \lor A$
   a) $F \lor A$
   a) $P \land \neg P$
   a) $P \lor \neg P$
   
5. Verify the following using truth tables:
   a) $P \land Q = Q \land P$
   a) $P \lor Q = Q \lor P$
   a) $P \land (Q \lor R) = (P \land Q) \lor (P \land R)$
   a) $P \lor (Q \land R) = (P \lor Q) \land (P \lor R)$
   a) $\neg (P \land Q) = \neg P \lor \neg Q$
   a) $\neg (P \lor Q) = \neg P \land \neg Q$

4. If you prove an equality of boolean expressions, for example, $\neg (P \land Q) = \neg P \lor \neg Q$, then if you replace every $\lor$ with $\land$, every $\land$ with $\lor$, every $T$ with $F$, and every $F$ with $T$ in that expression, you get a new equality of expressions called the "dual" which is also guaranteed to be true (in this example, $\neg (P \lor Q) = \neg P \land \neg Q$ is the dual of the example).
   a) Identify any pairs of dual expressions in the previous exercise. Therefore, you need only have verified one per pair.
   b) Why do you think this principle of duality holds?

2. Now that you have verified many simple boolean equations using truth tables, try to use them to simplify the following boolean expressions:
   a) $(\neg P \lor \neg Q) \land (\neg P \lor Q)$
   b) $\neg P \land \neg (P \lor Q)$

3. During the lecture we discussed a method to derive a boolean expression from its truth table, by looking at the rows whose output is $T$.  Can you come up with an analogous method that involves looking at the rows whose output is $F$?

