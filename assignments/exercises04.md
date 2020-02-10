---
title: Exercise sheet 4
---


1. Design a non-deterministic finite state automaton over the alphabet $\Sigma=\{0,1\}$ that will recognize the following languages (try to design a deterministic one too to get a feel for how much easier it is to design a non-deterministic one).
   a) Strings with the $n$th last character 0, for any natural number $n$.
   b) Strings that begin with $01$.
   c) ... **to be completed**
   
2. If $L_1$ and $L_2$ are regular languages, design a non-deterministic finite state automaton that recognizes:
   a) $L_1 \cup L_2$
   b) $L_1 \circ L_2 := \{xy \ |\ x\in L_1,\ y\in L_2\}$ (i.e. the concatentation of a string from $L_1$ with a string from $L_2$)
   b) $L_1^* := \{x_1x_2\ldots x_n \ |\ x_i\in L_1\}$ (i.e. concatenation of finitely many strings from the language)
   
3. Prove that any language that can be recognized by a non-deterministic finite state automaton can also be recognized by a deterministic one. Therefore, a language is regular if and only if it can be recognized by a non-deterministic finite state automaton.

**to be completed**
