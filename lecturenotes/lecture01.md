---
title: Quantifiers
date: 16 January, 2020
author: Dhruva Sambrani
---

## Quantifiers ##

### Existential quantifier ∃ - ###

There exists some x in the domain of discourse where P(x) = True

∃ x P(x)

### Universal Quantifier ∀ - ###

For every x in domain in discourse, P(x) = True

∀ xP(x)

### Negation of Quantifiers ¬ ###

¬( ∀x P(x) ) ≡ ∃x ( ¬P(x) )
¬( ∃x P(x) ) ≡ ∀x ( ¬P(x) )

### Example - * Only to illustrate * ###

#### What is a limit? ####

Suppose a<sub>n</sub> → l

≡ ∃ l ( ∀ϵ>0 ∃N ∈ ℕ ( n>N ⟹ |a<sub>n</sub> - l|<ϵ ) )

≡ ∃ l ( ∀ϵ∈ℝ ∃N ∈ ℕ ( n>N ⩓ ϵ>0 ⟹ |a<sub>n</sub> - l|<ϵ ) )

P(n) = "n > N"

Q(ϵ) = "ϵ > 0"

R(l,ϵ,n) = |a<sub>n</sub> - l|<ϵ

Hence -

∃l(∀ϵ∈ℝ ∃ N∈ℕ ∀ n( P(n)⩓Q(ϵ) ⟹ R(l,ϵ,n) ))

#### Negation of Above ####

If a<sub>n</sub> does not converge,

¬( ∃l ( ∀ϵ∈ℝ ∃N∈ℕ ∀n ( P(n)⩓Q(ϵ) ⟹ R(l,ϵ,n) ) ) )

∀l ¬( ∀ϵ∈ℝ ∃N∈ℕ ∀n∈ℕ ( P(n)⩓Q(ϵ) ⟹ R(l,ϵ,n) ) )

∀l ∃ϵ∈ℝ ¬( ∃N∈ℕ ∀n∈ℕ ( P(n)⩓Q(ϵ) ⟹ R(l,ϵ,n) ) )

∀l ∃ϵ∈ℝ ∀N∈ℕ ¬( ∀n∈ℕ ( P(n)⩓Q(ϵ) ⟹ R(l,ϵ,n) ) )

∀l ∃ϵ∈ℝ ∀N∈ℕ ∃n∈ℕ ¬( P(n)⩓Q(ϵ) ⟹ R(l,ϵ,n) ) )

∀l ∃ϵ∈ℝ ∀N∈ℕ ∃n∈ℕ ( P(n) ⩓ Q(ϵ) ⩓ ¬R(l,ϵ,n) ) )

In English, for all l, there exists ϵ in ℝ and there exists n and N in ℕ such that n>N and ϵ > 0 and | a<sub>n</sub> - l | NOT < ϵ

## Proofs * only to illustrate * ##

### General Domains ###

- To disprove ∀xP(x) just find an x.
- To prove ∃xP(x), just find an x.

### Finite Domains ###

One could potentially just run through all to either prove or disprove.

### Enumeratable Domains ###

∀ is easy to show by induction.

### Contradiction ###

If either ∀ or ∃ is difficult to show, or if ¬P(x) is more well known, you can disprove the negation of the predicate.

## Full Adder * only to illustrate * ##

Truth Table -

|in1|in2|out|carry|
|-|-|-|-|
|0|0|0|0|
|0|1|1|0|
|1|0|1|0|
|1|1|0|1|

Hence out is the XOR (¬P⩓Q) ⩔ (¬Q⩓P)

Carry is the And P⩓Q

> Tangential remark: While we can always derive an expression from a truth table, in practice it may be better to conceptualize the function as combinations of simpler ones. So, to realize an adder as compositions of basic boolean operations, using the truth table approach is not feasible, since it will be too big. Instead, one can realize it as a combination of two types of functions: one that outputs the sum of two bits, and the other that outputs the carry over. These two functions are small enough to use the truth table approach and realize it as a combination of AND, OR, and NOT
