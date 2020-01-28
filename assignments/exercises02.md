---
title: Exercise sheet 2
---

1. Prove that the following are tautologies.
   a) $P \land Q \Rightarrow P$
   a) $((P \Rightarrow Q) \land (Q \Rightarrow R)) \Rightarrow (P \Rightarrow R)$
   a) $((P_0 \Rightarrow P_1) \land (P_1 \Rightarrow P_2) \land \ldots \land (P_{n-1} \Rightarrow P_n)) \Rightarrow (P_0 \Rightarrow P_n)$
   b) $(P \Rightarrow Q) \land (Q \Rightarrow P) \Rightarrow (P \Leftrightarrow Q)$

2. Consider the predicate $P(x,y,z) := ``2x + 5y - 6z = 1"$.  Which of the following propositions are true:
   a) $\forall x \forall y \forall z P(x, y, z)$
   a) $\forall x \forall y \exists z P(x, y, z)$
   a) $\forall x \exists y \exists z P(x, y, z)$
   a) $\exists x \exists y \exists z P(x, y, z)$
 
2. Let $Q(x, y)$ denote the predicate "x is a question from Quiz y". Let $D(x)$ denote the predicate "x is difficult". Write expressions for the following statements using quantifiers, $Q$, and $D$:
   a) "Quiz 3 has exactly one difficult question"
   a) "Every quiz will have at least one difficult question"
   b) "For some quizzes,  every question will be difficult"
   c) "For some quizzes, *at most one* question will be easy"
  
4. Which of these are true no matter what the predicate $P(x, y)$ is. For each of the others, find an example for which it does not hold.
	a) $\forall x \exists y P(x,y) \equiv \exists y \forall x P(x,y)$.
	a) $\forall x \forall y P(x,y) \equiv \forall y \forall x P(x,y)$.
	a) $\exists x \exists y P(x,y) \equiv \exists y \exists x P(x,y)$.

3. One can define a new quantifier $\exists! x P(x)$ to mean that "there exists a *unique* x such that $P(x)$ is true". Show that this can always be expressed by an expression involving only the usual two quantifiers, $\exists$, and $\forall$.  *(Hint: you want to say that it exists **and** is unique. What does it mean to say that there is a unique x satisfying a predicate? Try considering its negation if that helps. You may assume that there is some notion of equality between the objects under consideration so that it makes sense to ask if "$a = b$" for any given $a$ and $b$)*

