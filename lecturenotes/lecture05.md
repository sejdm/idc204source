---
title: Regular Languages, Pumping Lemma and existance of an FSA for a Language
date: January 29, 2020
author: Dhruva Sambrani
---

Continued -

Q. Find an automaton which accepts a string from L where L on Σ = {0,1} where \#0 == \#1.

Let the automaton is finite and size N.
A string that is accepted with no repetition of state must be of less than N length. Any longer string must have a repeated state.

0<sup>N</sup>1<sup>N</sup> must be accepted.
Suppose it is accepted. Then there must be a repetition of states in the first N characters. Suppose r<sub>i</sub> = r<sub>j</sub>. Then 0<sup>i</sup> takes it to r<sub>i</sub> and 0<sup>j-i</sup> then takes it _back_ to r<sub>i</sub>. If we add (0<sup>j-i</sup>)<sup>k</sup> after 0<sup>i</sup>, the resulting string will also be accepted by the automaton. But this string has more 0s than 1s. Hence ∄ a finite automaton.

## Proposition ##
**Regular Language** A language is said to be a regular if there exists a deterministic FSA, that recognizes it.

## Pumping Lemma ##
If L is a regular language, then ∃ a natural number _N_ called the pumping length such that if w is a string in L (i.e. w∈L) & |w| ≥ N, then we can write w=xyz such that

   1. y is not empty
   2. |xy| ≤ N
   3. xy<sup>i</sup>z also belogs to L ∀ i=0,1,2,3...

L is a set of strings over {0,1} st the number of 0s exceeds the number of 1s.
Not regular. Pumping lemma on 1<sup>N</sup>0<sup>N+1</sup> proves it.
