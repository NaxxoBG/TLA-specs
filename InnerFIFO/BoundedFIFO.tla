---------------------------- MODULE BoundedFIFO ----------------------------

EXTENDS Naturals, Sequence
VARIABLES in, out

CONSTANT Message, N

ASSUME (N \in Nat) /\ (N > 0)

Inner(q) == INSTANCE InnerFIFO

BNext(q) == 
           /\ Inner(q)!Next
           /\ Inner(q)!BufRcv => (Len(q) < N)

Spec == \E q : Inner!Init /\ [][BNext(q)]<<in, out, q>>

=============================================================================
\* Modification History
\* Last modified Thu Feb 21 10:55:24 CET 2019 by Naxxo
\* Created Thu Feb 21 10:37:40 CET 2019 by Naxxo
