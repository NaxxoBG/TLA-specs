----------------------------- MODULE RoundRobin -----------------------------

EXTENDS Naturals, Reals, TLC

VARIABLES phone, chan, pc

CONSTANT MAXP

IDs == 0..MAXP

TypeInvariant == 
                 /\ IDs \in (0..MAXP-1)
                 /\ phone \in [IDs -> BOOLEAN]
                 /\ chan \in [IDs -> 0..1]
                 /\ pc \in [IDs -> 1..4]

Init ==
        /\ phone = [p \in IDs |-> 1]
        /\ chan = [[p \in IDs |-> 0] EXCEPT ![0] = 1]
        /\ pc = [p \in IDs |-> 1]
        
        
Proc1(n) ==
            /\ pc[n] = 1
            /\ chan[n] = 1
            /\ pc' = [pc EXCEPT ![n] = 2]
            /\ UNCHANGED <<chan, phone>>

Proc2(n) ==
            /\ pc[n] = 2
            /\ phone' = [phone EXCEPT ![n] = TRUE]
            /\ pc' = [pc EXCEPT ![n] = 3]
            /\ UNCHANGED chan

Proc3(n) ==
            /\ pc[n] = 3
            /\ phone' = [phone EXCEPT ![n] = FALSE]
            /\ pc' = [pc EXCEPT ![n] = 4]
            /\ UNCHANGED chan

Proc4(n) ==
            /\ pc[n] = 4
            /\ chan' = [chan EXCEPT ![n] = 0, ![(n + 1) % MAXP] = 1]
            /\ pc' = [pc EXCEPT ![n] = 1]
            /\ UNCHANGED phone

Proc(n) == 
            \/ Proc1(n)
            \/ Proc2(n)
            \/ Proc3(n)
            \/ Proc4(n)

Next == \E n \in IDs : Proc(n)

Spec == Init /\ [][Next]_<<phone, chan, IDs, pc>> /\ WF_ <<phone, chan, IDs, pc>>(Next)

=============================================================================
\* Modification History
\* Last modified Tue Apr 02 09:20:44 CEST 2019 by Naxxo
\* Created Tue Apr 02 08:38:02 CEST 2019 by Naxxo
