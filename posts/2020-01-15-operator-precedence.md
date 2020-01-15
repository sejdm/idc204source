---
title: Boolean operator precedence
---

Since some of you requested, here is the order in which boolean operators are given precedence:

1. $\neg$
2. $\land$
3. $\lor$
4. $\Rightarrow$, $\Leftrightarrow$

The convention allows us to drop parentheses in many cases, even if they involve different types of operators, to make the expressions more readable. 

Therefore, in the expression, $\neg P \land Q \lor R \Leftrightarrow S \land T$, the parentheses are implied and the expression means, $((\neg P \land Q) \lor R) \Leftrightarrow (S \land T)$. On the other hand, $\neg P \land (Q \lor R) \Leftrightarrow S \land T$ is a different expression and the parenthesis is essential because despite $\lor$ having a lower precedence than $\land$, we are evaluating $Q \lor R$ *before* combining it with $\neg P$ using $\land$.


