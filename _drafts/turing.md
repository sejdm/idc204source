---
title: Turing machines
tableOfContents: true
---


## Why are they important?

Turing machines will turn out to be more powerful than all the previous computation models that we have seen: any language that can be recognized by a finite state automaton or a push down automaton, can also be recognized by a Turing machine.  Some languages cannot be recognized by automata but can be recognized by a Turing machine.  In fact, despite their simply definition, Turing machines are really powerful: if you can write a program for any computation, no matter how complex, you can build a Turing machine to perform the same computation! Attempts at alternatives that can perform computations that a Turing machine cannot, have so far failed (although they may be more efficient). In this course, we will see how some attempts to "enhance" a Turing machine fail to make it more powerful, i.e. anything that the "enhanced" machine can compute, the original one can too. This is similar to the situation with non-deterministic vs deterministic automata. 

Despite their power, Turing machines are merely abstract models of computation and though you can actually build a physical model of it, it would be too inefficient to use in practice.  But we will soon see that we can use the concept of a Turing machine to prove certain very fundamental questions about computability. For instance, we will show that some natural problems cannot be solved by any Turing machine, however complex it may be. Therefore, it cannot be done by any program either. This is why we will study Turing machines. Furthermore, if you can write a program in your favourite programming langauge that can simulate any Turing machine, given its designs, then you know that it is equivalent to a Turing machine and, therefore, what you can do in another programming language can also be done in your favourite one [^1]. 

[^1]: This is why they say, "it is not what a programming language can do that matters, but what it makes easy"


## Motivation

This section is not meant to be very formal and may be skipped if you are annoyed by this sort of thing. The purpose is to reflect upon what characterizes a computation and how that leads to the definition of a Turing machine.


### Computations

Consider any algorithm that you perform by hand, like sorting a massive list in alphabetical order, dividing two numbers by long division, differentiating a big function etc. 

If you were to do this on the board and do everything explicitly, you will begin by writing the question or the input on the board. You will perform the task in steps where each step consists of focussing on a part of what you have written on the board,  alter it, and move to another part of the board to focus on, alter it, move to another part of the board and so on..

No matter how big the input, usually, the part that you need to focus on at a time is of limited size. For instance, in long division, you only need to focus on two or three digits at a time. In differentiation, you need to focus on at most two functions separated by an operator etc. This is a very important observation because it means the number of different possibilities of strings that are in focus are finite and fixed and is partly why we can describe such algorithms with finitely many characters although they can work on arbitrarily large inputs. Let $\Gamma$ denote this finite set of possible strings that can be in focus. Since this is only to explain the intuition, I am not too concerned about how I really define the region that is in focus. All that is important is that the possible strings that I can fit in that region are finite.

Let us also denote the possible directions we can move our focus to as $D$. For instance $D$ can contain the directions up, down, left, right. Again, since this is a provisional definition, I do not care to be more precise.  

If, on the basis of the string that is in focus, we alter the string and choose a new direction to shift focus to, we can capture that by a function $f : \Gamma \to \Gamma \times D$, so that $f(x) = (x', d)$ means, if $x$ is focus, erase it and write $x'$ instead (in practice, you would only erase the part that differs) and shift focus in direction $d$. However, this is not enough: if you were to react to the string in focus in exactly the same way for every step, it would be too restrictive. For instance, assume that your computation needed you to refer to the answer to some intermediate computation that you had written on the board. To search for it you would be scanning through the board and in turn focussing on many parts that you will for now leave unaltered because you are currently "in the state of" searching for something. However, you may change those parts later if another step of the algorithm requires it. 

We can correct the situation by introducing a finite set which we denote as $Q:=\{q_0, q_1, q_2, \ldots, q_n, q_{stop}\}$. Think of $q_i$'s as just labels for how we will react to whatever is in focus. We can then introduce a function $\delta : Q \times \Gamma \to Q \times \Gamma \times D$, so that $\delta(q_i, x) = (q_j, x', d)$ will replace the string, $x$, in focus with the string, $x'$, and shift focus in direction $d$, depending on what label $q_i$ is plugged into the first argument. It also outputs, $q_j$, which will help to decide what label it should use to react to what is in focus in the next step. If, for each possible $x$ in the next step, it should output the same $x'$ and $d$ as in this step, then $q_j$ can be equal to $q_i$, otherwise we can choose a different one. These $q_i$'s are called states and we start with state $q_0$ and stop only if we reach the state $q_{stop}$.

What is a state? We had discussed this point when talking about automata and exactly the same idea applies here. From the point of view of the computation, that question is of no consequence. All that matters is that a state is characterized by how it makes you react to what you are focussing on. If two states make you react to all possibilities in the same way, they are for all practical purposes the same state. In other words, if $\delta(q_i, x) = \delta(q_i, x)$ for all $x$, then you may as well take $q_i = q_j$ and there will be no difference in the way your computation works.

Now $\delta$ is essentially defining your algorithm. In order for the description of the algorithm to be finite, it is important that the domain of $\delta$ be finite, and therefore, $Q$ and $\Gamma$ must be finite.

**To summarize:** We have a finite set $Q$ that serves as a set of labels or states, a finite set $\Gamma$ of possible strings in focus, a set $D$ of directions to shift focus on the board, and a function $\delta : Q \times \Gamma \to Q \times \Gamma \times D$. You start at the beginning of the board and with state $q_0$. Use $\delta$ to figure out what to erase and write on that part of the board, what direction to shift focus to, and what state to be in for the next step. Repeat this step until $\delta$ outputs the state $q_{stop}$. Since the domain of $\delta$ is finite, it can be explicitly written in the form of a table. Using this method, you can reduce your computation to a mindless manipulation of symbols and you need not care about the meaning of the steps. Therefore, we can hope to simulate it using a machine.

### An example

In school you learned to sum two integers expressed in decimals without knowing the meaning of addition. Let us revisit the algorithm and see how it reduces to merely manipulation of symbols and why the description of the algorithm is finite and fixed despite the fact that it can work for arbitrarily large numbers.

The algorithm involves writing the two numbers one below the other, and lining up their digits to form colums. They are right aligned, and we begin focussing on the right most column.

In this example, we need only one state, $q_0$, apart from $q_{stop}$ because we are always doing the same thing in each step, i.e., adding the numbers in the column in focus, always shifting left.  In the tables below, the characters in focus are shown in bold and the blank spaces in focus are marked with a dot.


Step 0: $q_0$

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


Note that there are only finitely many possibilities to consider for what is in focus; including the blank symbol, there are 11 possibilities each for the previously carried over digit, 11 for the digit from the first number, and 11 from the digit of the second number; a total of 1331 possibilities. That is why the domain of $\delta$ is finite and one can write the mapping explicitly once and for all refer to it. 1331 entries makes it a rather long function because we have decided to stick to decimal rather than binary, but remember it works for any input, however large so its size is a small price to pay.


## The actual definition

We are now ready to define a Turing machine and make all of this precise. We will do so by making modifications to the above informal procedure in order to make it theoretically clean.

The input will be expressed as a string of characters. So we have an alphabet $\Sigma$ which is a finite set of characters from which we form the input string.

Now rather than using a two dimensional board to write intermediate computations, why not use an infinite tape on which we can can write any string as one long row as shown below:

+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 1 | . | . | . | . | . | . | . | . | . | . | . | . | . | . | . | . |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+


The tape consists of cells on which only one character can be written. One essential difference: the tape is infinite. While it has a starting cell, it has no ending cell. However, even though the tape is infinite, that is only to ensure that there is as much memory as required for the computation. However, at no point is more than finitely many characters written on the tape. Most cells remain blank.


Now how many cells must we include in the focus? Why not simplify matters and allow only 1? [^2] 


[^2]: Search for the "0, 1, infinity rule"!

In fact, the focus is called the "head". We can now shift focus from one cell to another by repeadly moving left or right, and therefore the set of directions need only be, $D=\{L, R\}$.

2. Here we imagined everything was written on a two dimensional paper, but describing how to shift on a two dimensional page is more complex than describing how to shift on a one-dimensional "tape". Therefore, we replace page with a long never-ending tape consisting of cells that can hold only one character of the alphabet at a time. The head can move across the tape in only two directions: left or right, and only the character under the head can be altered. The tape has a start cell but extends indefinitely to the right. By convention, if we are the start cell and move left, we remain at the start cell.



A Turing machine consists of 

1. an infinite tape of cells, a head that focusses on a particular cell of the tape and which can be shifted left or right
2. a finite set of states with a start state, and two special states called "accept state" and "reject state", 
3. and a transition function that takes as inputs the current state and the current character under the head, and outputs the new state, the new character to replace the one under the head, and the direction to move the head to (either left or right).

The machine works by using the transition function to alter what is under the head, and shift to a new state, and shift the head. It repeats this until it reaches either the accept or reject state, in which case it stops.  If the problem is a language recognition one, then one can decide to accept or reject the state depending on whether halted with the accept state or the reject one. If one desires an output, then one reads the tape after the machine has halted.

Now the formal definition of a Turing machine given in the book should make sense to you.






