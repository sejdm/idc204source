---
title: More on Languages
date: January 22, 2020
author: Dhruva Sambrani
---

## Languages Continued ##

Σ\* = set of all strings over the alphabet Σ

A language L<sub>1</sub> is a subset of Σ\*

ϵ is an empty string.

If ω \in Σ\*, |ω| = length of the string.

### Examples of languages ###
1.  ∅
2.  Σ\*
    > English is a language where the strings are all words in a dictionary and punctuation marks and the collection is _grammatically_ correct
    >
    > C++ any string of characters the compiler accepts
3.  Σ = {a,b}, L = {x∈Σ\* st x begins with a & ends with b}
4.  Σ = {0,1,..,9}, L={x | x is the decimal representation of a prime}

### Equality of Languages ###
Languages are equal if the set of strings are equal.

### Encoding (_informal_) ###
A bijective mapping from one set to another.
-   Pictures are colours encoded as numbers
-   Similarly movies

## Ordering of a language ##
Σ is finite, hence can be ordered.

Σ* can then be ordered by length first and then the lexographic order on Σ

## Existance of a string in a Language ##
### Graph of a function ###
G(f) = {x,y | y=f(x)}

A string exists in the language if it exists in G(f) where f is the defining function of the Language.

> There are uncountable languages but a countable set of strings.
> So we cannot hope to describe all the languages using strings.

### Deterministic Finite State Automaton ###

Solve the existance of string problem
-   Read the string one char at a time
-   Remember something, and react to the next char accordingly.
-   Do this again and again

Consider -

Σ = {0,1}

l = {x|x consists of an even number of 1s}

Given a string, what do you do?

Go char by char, switching between an "even state" and an "odd state"

**DEFN:** Deterministic Finite State Automaton is a 5 tuple (Q, Σ, δ, q<sub>0</sub>, F) where

-   Q = A finite set called the set of states
-   Σ = Alphabet
-   δ = is a function Q×Σ → Q
-   q<sub>0</sub> ∈ Q and is called the initial state
-   F ⊆ Q and is the set of accepted states.
