---------------------------- MODULE BoundedLIFO ----------------------------
EXTENDS Naturals, Sequence
VARIABLES in, out

CONSTANT Message, N

ASSUME (N \in Nat) /\ (N > 0)

Inner(q) == INSTANCE InnerLIFO

BufNext(q) == 
           /\ Inner(q)!Next
           /\ Inner(q)!BufRcv => (Len(q) < N)

Spec == \E q : Inner!Init /\ [][BufNext(q)]_<<in, out, q>>
=============================================================================
\* Modification History
\* Last modified Thu Feb 21 12:26:58 CET 2019 by Naxxo
\* Created Thu Feb 21 12:26:54 CET 2019 by Naxxo
