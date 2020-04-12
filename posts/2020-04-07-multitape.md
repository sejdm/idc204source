---
title: Multitape Turing Machine
---

## The formal definition

$$(Q, \Sigma, \Gamma, \delta, q_{accept}, q_{reject})$$

$$\delta : Q \times \Gamma^k \to Q \times \Gamma^k \times \{L, R, S\}^k$$

## The steps

#### 

Step 1: Find out what is "under the heads"
Step 2: Apply $\delta$ to know the output
Step 3:  Update the simulated tapes

#### 

- Sweep right 


#### States

Let us first list the information that we need to remember while sweeping between cells on the tape:

1. The number of the simulated tape in focus. So define, $$N := \{1, 2, \ldots, k\}$$.
2. The current state, i.e. element of $Q$. But in the beginning, we may have nothing. So, $$\tilde{Q} = Q \cup \{\text{Nothing}\}$$
3. The characters under the simulated heads, i.e. $\Gamma^k$
4. The output of $\delta$, i.e. $$Y:=Q \times \Gamma^k \times \{L, R, S\}^k \cup \{\text{Nothing}\}$$

So we take the set of states $$Q' \subset S \times \tilde{Q} \times \tilde{\Gamma}^k \times Y$$. Once again, it is a subset, because not all of them are required. In fact, all elements from the $Y$ component are already determined by the previous two components. 



$$((\text{Step 0}, \alert{2}, q_i, (0,1, \text{Nothing}, \ldots), \text{Nothing}),\  \alert{{\tt \#}})$\\ $\to ((\text{Step 0}, \alert{3}, q_i, (0, 1, \text{Nothing}, \ldots), \text{Nothing}), \alert{{\tt \#}}, \text{R}))$$

$$((\text{Step 0}, {\color{blue}3}, q_i, (0,1, \text{Nothing}, \ldots), \text{Nothing}),\  \alert{\text{A}})$\\ $\to ((\text{Step 0}, 3, q_i, (0, 1, \alert{0}, \ldots), \text{Nothing}), \alert{\text{A}}, \text{R}))$$

$$((\text{Step 0}, {\color{blue}3}, q_i, (0,1, \text{Nothing}, \ldots), \text{Nothing}),\  \alert{\text{B}})$\\ $\to ((\text{Step 0}, 3, q_i, (0, 1, \alert{1}, \ldots), \text{Nothing}), \alert{\text{B}}, \text{R}))$$
