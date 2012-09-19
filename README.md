Ecurry
======

a simple way to curry a function and define a partial application.

USAGE:

```
F = ecurry:curry(fun (A, B, C, D) -> {A, B, C, D} end).
F0 = F(1).
F1 = F0(2).
F2 = F1(3).
F3 = F2(4). % {1, 2, 3, 4}

P = ecurry:partial(fun (A, B, C, D) -> {A, B, C, D} end, [1, 2]).
P(3, 4). % {1, 2, 3, 4}
```
