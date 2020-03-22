---
title: Turing machines
tableOfContents: true
---


## Why are they important?

Turing machines will turn out to be more powerful than all the previous computation models that we have seen: any language that can be recognized by a finite state automaton or a push down automaton, can also be recognized by a Turing machine.  Some languages cannot be recognized by automata but can be recognized by a Turing machine.  In fact, despite their simple definition, Turing machines are really powerful: if you can write a program for any computation, no matter how complex, you can build a Turing machine to perform the same computation! Attempts at alternatives that can perform computations that a Turing machine cannot, have so far failed (although they may be more efficient). In this course, we will see how some attempts to "enhance" a Turing machine fail to make it more powerful, i.e. anything that the "enhanced" machine can compute, the original one can too. This is similar to the situation with non-deterministic vs deterministic automata. 

Despite their power, Turing machines are merely abstract models of computation and though you can actually build a physical model of it, it would be too inefficient to use in practice.  But we will soon see that we can use the concept of a Turing machine to prove certain very fundamental questions about computability. For instance, we will show that some natural problems cannot be solved by any Turing machine, however complex it may be. Therefore, it cannot be done by any program either. This is why we will study Turing machines. Furthermore, if you can write a program in your favourite programming langauge that can simulate any Turing machine, given its designs, then you know that it is equivalent to a Turing machine and, therefore, what you can do in another programming language can also be done in your favourite one [^1]. 

[^1]: This is why they say, "it is not what a programming language can do that matters, but what it makes easy"


## Motivation

This section is not meant to be very formal and may be skipped if you are annoyed by this sort of thing. The purpose is to reflect upon what characterizes a computation and how that leads to the definition of a Turing machine.


The tables below show the steps of a common algorithm used to add two numbers (in this example, 2356 and 4579).

Step 0

|   |   |   |       |       |
|---|---|---|-------|-------|
|   |   |   | **.** | **.** |
|   | 2 | 3 | 5     | **6** |
|   | 4 | 5 | 7     | **9** |
|   |   |   |       | **.** |




Step 1: $q_0$

|   |   |       |       |     |
|---|---|-------|-------|-----|
|   |   | **.** | **1** |     |
|   | 2 | 3     | **5** | 6   |
|   | 4 | 5     | **7** | 9   |
|   |   |       | **.** | *5* |


Step 2: $q_0$

|   |       |       |     |     |
|---|-------|-------|-----|-----|
|   | **.** | **1** | 1   |     |
|   | 2     | **3** | 5   | 6   |
|   | 4     | **5** | 7   | 9   |
|   |       | **.** | *3* | *5* |


Step 3: $q_0$

|       |       |     |     |     |
|-------|-------|-----|-----|-----|
| **.** | **0** | 1   | 1   |     |
|       | **2** | 3   | 5   | 6   |
|       | **4** | 5   | 7   | 9   |
|       | **.** | *9* | *3* | *5* |



Step 4: $q_0$

|       |     |     |     |     |
|-------|-----|-----|-----|-----|
| **0** | 0   | 1   | 1   |     |
| **.** | 2   | 3   | 5   | 6   |
| **.** | 4   | 5   | 7   | 9   |
| **.** | *6* | *9* | *3* | *5* |


Step 5: $q_{stop}$

|   |     |     |     |     |
|---|-----|-----|-----|-----|
| 0 | 0   | 1   | 1   |     |
|   | 2   | 3   | 5   | 6   |
|   | 4   | 5   | 7   | 9   |
|   | *6* | *9* | *3* | *5* |

Note that in every step, we have only made use of symbols from the alphabet, $\Sigma := \{0, 1, \ldots, 9, blankspace\}$.

The same algorithm works no matter how large the input, because each step need focus on only a small part (five cells of the table) at a time (shown in bold and with a dot when the cell is empty). Since each cell can have at most 10 possible entries, the number of possible variations of what is in focus form a *finite* set, which we will denote by $\Gamma$.

In each step, based on what is in focus, we alter its contents and shift focus in a new direction (in this example, we always shift left). If we denote the set of directions by $D$, then we are essentially applying a function $F : \Gamma \to \Gamma \times D$. The function takes as input the string that is in focus and outputs the new string that is to replace it as well as the direction to shift focus to.

Since $\Gamma$, which is the domain of $F$, is finite, the entire function $F$ can be defined using a finite table of mappings:

$$ x_1 \to (y_1, d_1)\\
x_2 \to (y_2, d_2)\\
\cdots$$

One would normally evaluate the output of $F$ by performing a tiny little calculation, however, to simplify this discussion, let us note that we can also do it by simply referring to that table. The table may be big, but is finite and of fixed size no matter how big the input is.

When we reach the step where no input digits are in focus, we stop and the last row is the final answer.

In this example we need only one function $F$ because we are always doing the same thing in each step: "adding the single digits, updating the sum and carry over and shifing focus to the left". In more complicated computations, we may need to switch to a different function under certain circumstances. 

We can do this by introducing a finite set which we denote $Q:=\{q_0, q_1, q_2, \ldots, q_n, q_{stop}\}$. For now, think of $q_i$'s as labels. They are usually called states. We can then introduce a function $\delta : Q \times \Gamma \to Q \times \Gamma \times D$, so that $\delta(q_i, x) = (q_j, x', d)$ may be interpreted as: "if the current state is $q_i$ and $x$ is in focus, then replace $x$ with the string $x'$, shift focus in direction $d$, and switch to state $q_j$."  We begin the computation in state $q_0$ and stop whenever the $q_{stop}$ is outputted.

The fact that $Q$ is finite, along with the fact that $\Gamma$ is finite, ensures that $\delta$ has a finite domain and may also then be described by a table like this:


|       | $x_0$           | $x_1$    |
|-------|-----------------|----------|
| $q_0$ | $(q_i, y_j, d)$ | $\cdots$ |
| $q_1$ | $\cdots$        | $\cdots$ |




## The actual definition

We will now make modifications to the above informal description of a computation to define a Turing machine.
In the example above, we performed intermediate computations on a two-dimensional page or blackboard.
Instead, we will use a tape on which we can can write any string as one long row as shown below, so we only need two directions, left and right, i.e. $D=\{L, R\}$.

+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 1 | . | . | . | . | . | . | . | . | . | . | . | . | . | . | . | . |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+


The tape is divided into cells; only one character can be written on each cell. One essential difference: the tape is infinite to ensure that there is always as much memory as needed. However, the tape *always* has at most finitely many cells occupied. The information stored is always finite, but since we do not know how much may be required for a given computation, enough tape is available.


Now how many cells must we include in the focus? Why not simplify matters and allow only 1? [^2]  Since at exactly one character is in focus at a time, $\Gamma$ is a set of characters, and is called the "tape alphabet". Of course, since we must be able to write the original input on the tape, it must contain the input alphabet $\Sigma$ as a subset, i.e. $\Sigma \subset \Gamma$

The focus is called the "head".  The machine can move the head left or right to bring the appropriate cell in focus. Here, the head is shown with an arrow.


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $\downarrow$

+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 1 | . | . | . | . | . | . | . | . | . | . | . | . | . | . | . | . |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+


[^2]: Search for the "0, 1, infinity rule"!


A Turing machine consists of 

1. A finite set, $\Sigma$, called the alphabet.
2. A finite set, $\Gamma$, called the tape alphabet, such that $\Sigma \subset \Gamma$.
3. The set of $D:=\{L, R\}$ of directions
4. A function $\delta : Q \times \Gamma \to Q \times \Gamma \times D$
4. A finite set, $Q$, called the set of states
5. A special element $q_0 \in Q$, called the start state
5. Two special elements $q_{accept}, q_{reject} \in Q$, called the accept state and reject state, respectively.


The machine starts at the state $q_0$, with the head at the beginning of the tape, and the input string written on the tape. If the character under the head is $x$, then $\delta(q_0, x)$ is evaluated to be say, $(q_i, y, d)$. The machine then replaces $x$ with $y$ in the cell under the head, shifts the head to the left if $d=L$ otherwise it shifts to the right, and moves to state $q_i$. Then it reads the character, $z$, under the current head position, evaluates $\delta(q_i, z)$ and uses that to decide what to replace it with , which state to shift to, and which direction to move the head to. This process it repeats over and over again until it reaches either the state $q_{accept}$, in which case it accepts the input string, or the state $q_{reject}$, in which case it rejects the input string.

Now the formal definition of a Turing machine given in the book should make sense to you. We will see some examples in the coming posts.




