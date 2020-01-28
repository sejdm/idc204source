---
title: Sets
date: 20 January, 2020
author: Dhruva Sambrani
---

## Sets ##
Set is a well defined collection of objects. _Well defined_ here means that an element of the Domain x should be **unambigiously** belong to or not belong to set S.

x∈A ≡ "x belongs to set A"

x∉A ≡ "x does not belong to set A"

### Properties ###
- All elements unique.
- Unordered.

### Types ###
Sets need not be of a particular "type" - {{1,2,3},6,7}
May also be infinite. {1,2,3,4....}
Null/Empty set = {} = ∅

### Operations on sets ###
- Subset: A⊆B. "A is a subset of B." x∈A<b>⟹</b>x∈B.
- Equality: A=B iff A⊆B ⩓ B⊆A. "A is equal to B." x∈A ⟹ x∈B ⩓ x∉A ⟹ x∉B
- Proper Subset: A⊂B x∈A ⟹ x∈B ⩓ A≠B.
- Complement: U∖A **OR** A<sup>c</sup>. Exactly all x's in U NOT in A.
- Union: A∪B. "A union B". Exactly all elements in A ⩔ B.
    - If {A<sub>α</sub>} is a collection of sets indexed by I, then ⋃A<sub>α</sub> = set of x st x∈<sub>α<sub>0</sub></sub> for some α ∈ I.
- Intersection: A∩B "A intersection B". Contains exactly all elements in A **AND** B.
    - x∈ ⋂A<sub>α</sub> iff x ∀α∈I, x∈A<sub>α</sub>
- Cartesian Product: A×B "Cartesian Product of A and B". Its the collection of all 2 element sequences (a,b) st a∈A, b∈B
    - A<sub>1</sub>×A<sub>2</sub>×...×A<sub>n</sub> is the collection of all n element sequences (a<sub>i</sub>) st a<sub>i</sub>∈A<sub>i</sub>
- Relation operator: aRb "a is related to b". A relation is a subset of A×B.
- Function: f: A → B. It is a relation such that
    1. ∀a∈A, ∃b st aRb.
    2. aRb and aRc ⟹ b=c.
    - Equality of functions - f=g ⟹ f⊆g ⩓ g⊆f.

## Languages ##
Σ is a finite set called an "alphabet".

The finite sequence is called a string.

A language over Σ is _a_ set of strings.
