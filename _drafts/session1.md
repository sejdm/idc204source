
# Turing machine

$(Q, \Sigma, \Gamma, \delta, q_{accept}, q_{reject})$

- $Q$: Set of states
- $\Sigma$: Alphabet
- $\Gamma$: Tape alphabet. $\Sigma \subset \Gamma$.
- $\delta$: Transition function, $\delta : Q \times \Gamma \to Q \times \Gamma \times \{L, R\}$.
- $q_{accept}$: Accept state. $q_{accept}\in Q$
- $q_{reject}$: Reject state. $q_{reject}\in Q$

# Example 1

Strings over $\Sigma:=\{0, 1, =\}$ of the form $w=w$.




# Example 2

Strings over $\Sigma:=\{0, 1\}$ of the form $0^n$ where $n$ is a power of 2.



# Turing machine with the option of not moving the head

$(Q, \Sigma, \Gamma, \delta, q_{accept}, q_{reject})$

> - $Q$: Set of states
> - $\Sigma$: Alphabet
> - $\Gamma$: Tape alphabet. $\Sigma \subset \Gamma$.
> - $\delta$: **Transition function:** $\delta : Q \times \Gamma \to Q \times \Gamma \times \{L, R, S\}$.
> - $q_{accept}$: Accept state. $q_{accept}\in Q$
> - $q_{reject}$: Reject state. $q_{reject}\in Q$



# Multitape Turing machine


$(Q, \Sigma, \Gamma, \delta, q_{accept}, q_{reject})$


$\delta : Q \times \Gamma^k \to Q \times \Gamma^k \times \{L, R, S\}^k$




# Multitape Turing machine

## Simulating a tape's head

&nbsp;

Actual head:
```
  0  |0|  1   1   1
```
Simulated head, replaces `0` with `o`:
```
  0   A   1   1   1
```


# Multitape Turing machine

## Simulating a tape's head

&nbsp;

Actual head:
```
  0   0  |1|  1   1
```
Simulated head, replaces `1` with `I`:
```
  0   0   B   1   1
```

# Multitape Turing machine


Need more characters in the simulated Turing machine: 

$\Sigma':=\{$ `0,1,A,B,.` $\}$


| Without head | With head |
|--------------|-----------|
| `0`          | `A`       |
| `1`          | `B`       |
| *blankspace* | `.`       |

# Multitape Turing machine


Two tapes:
```
  0  |0|  1   1   1
```
```
  1   0   0  |0|  0
```

Simulated on one tape:

```
  0   A   1   1   1   #   1   0   0   A   0
```


# Multitape Turing machine


Two tapes:

```
  0   0  |1|  1   1
```
```
  1   0  |0|  0   0
```

Simulated on one tape:

```
  0   0   B   1   1   #   1   0   A   0   0
```

# Multitape Turing machine


Two tapes:

```
  0   0   1  |1|  1
```
```
  1   0  |0|  0   0
```

Simulated on one tape:

```
  0   0   1   B   1   #   1   0   A   0   0
```


# Multitape Turing machine


Two tapes:

```
  0   0   1   1  |1|
```
```
  1   0  |0|  0   0
```

Simulated on one tape:

```
  0   0   1   1   B   #   1   0   A   0   0
```



# Multitape Turing machine

Two tapes:

```
  0   0   1   1   1  | |
```
```
  1   0  |0|  0   0
```

Simulated on one tape:

```
  0   0   1   1   1   .   #   1   0   A   0   0
```
# Multitape Turing machine

To simulate two tapes, the alphabet needed in the single tape simulation:

$\Sigma':=\{$ `0,1,A,B,., #` $\}$

| Without head | With head |
|--------------|-----------|
| `0`          | `A`       |
| `1`          | `B`       |
| *blankspace* | `.`       |

`#`: Tape separator


# States 

$q_f$ = (saw a 0, searching for =)   
$q_{f'}$= (saw a 1, searching for =)   
$q_o$=(saw a 0, found =)   
$q_{o'}$=(saw a 1, found =)   
