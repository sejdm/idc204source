---
title: Finite State Automata
date: January 27, 2020
author: Dhruva Sambrani
---

## Finite State Automaton ##
M = (Q, Σ, δ, q<sub>0</sub>, f)
There is a set of states Q which M manipulates by δ over Σ and the string is accepted if it lies in f ⊂ Q, starting from q<sub>0</sub>.

q<sub>0</sub> ∈ Q, f ⊂ Q

> M always reads the entire input.

### Accepting a string ###

Given a string, S = c<sub>0</sub>,c<sub>1</sub>...c<sub>n</sub>, M accepts S iff ∃ r<sub>0</sub>, r<sub>1</sub>, ... r<sub>n+1</sub> ∈ Q, st
1. r<sub>0</sub> = q<sub>0</sub>
2. r<sub>i + 1</sub> = δ(r<sub>i</sub>, c<sub>i</sub>)
3. r<sub>n+1</sub> ∈ f

A language is recognized by M, iff L = {s | M accepts s}.

### Example ###
1. Define a Finite State Automaton that recognizes the language L = 101, Σ = {0,1}. Look at Fig 1 for implementation.


![FSA](/files/fsa.jpeg)


**Side note**

FSAs can be _implemented_ in more than one ways. Is there a _minimal_ implementation?

2. Define a Finite State Automaton that recognizes the language L = {s | s has equal 0s and 1s}, Σ = {0,1}

[Pigeonhole Principle](https://en.wikipedia.org/wiki/Pigeonhole_principle)

r<sub>0</sub> → r<sub>1</sub> → ... → r<sub>i</sub> → ... → r<sub>n</sub>

Continued in next class...
